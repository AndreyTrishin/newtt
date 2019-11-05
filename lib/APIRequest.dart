import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timetable_app/Models/Discipline.dart';
import 'package:timetable_app/Models/MarkRecord.dart';
import 'package:timetable_app/Models/Term.dart';
import 'package:timetable_app/Query.dart';
import 'package:xml/xml.dart' as xml;

import 'Models/User.dart';

class APIRequest {
  String server = 'http://1c-web-test.infocom.local/MobileDemo/ws/Study.1cws';

  Query query = Query();

  Future<User> authorisation(name, password) async {
    var responceAuth = await http.post(server,
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'SOAPAction': 'http://sgu-infocom.ru/study#WebStudy:Authorization',
          'Content-Type': 'text/xml;charset=UTF-8',
        },
        body: query.getAutorizationQuery(
            name, sha1.convert(utf8.encode(password))));
    var resultAuth = xml.parse(responceAuth.body);

//    print(resultAuth);

    var responceRecBook = await http.post(server,
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'Content-Type': 'application/xml',
        },
        body: query.getRecordbooksQuery(
            resultAuth.findAllElements('m:UserId').first.text));
    var resultRecBook = xml.parse(responceRecBook.body);
//    var userElement = resultAuth.findAllElements('m:User').first.text;
//    print(userElement);
//    print(resultRecBook);

    User user = User(
      resultAuth.findAllElements('m:UserId').first.text,
      resultAuth.findAllElements('m:Login').first.text,
      resultAuth.findAllElements('m:PasswordHash').first.text,
      resultRecBook.findAllElements('m:RecordbookId').first.text,
      resultRecBook.findAllElements('m:CurriculumId').first.text,
      resultRecBook.findAllElements('m:CurriculumName').first.text,
      resultRecBook.findAllElements('m:AcademicGroupName').first.text,
      resultRecBook.findAllElements('m:AcademicGroupCompoundKey').first.text,
      resultRecBook.findAllElements('m:SpecialtyName').first.text,
    );
    print(user.name);
    return user;
  }

  Future<List<List<MarkRecord>>> getEducationalPerformance(
      userId, recbookId) async {
    var responce = await http.post(server,
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'Content-Type': 'application/xml',
        },
        body: query.getEducationalPerformance(userId, recbookId));
    var result = xml.parse(responce.body);
//    print(result);

    List<List<MarkRecord>> listOfMarks = [];
    String term = 'Первый семестр';
    List<MarkRecord> list = [];

    for (var e in result.findAllElements('m:MarkRecord')) {
      if (term == e.findAllElements('m:Term').first.text) {
        list.add(MarkRecord(
          e.findAllElements('m:Block').first.text,
          e.findAllElements('m:Subject').first.text,
          DateTime.parse(e.findAllElements('m:Date').first.text),
          e.findAllElements('m:Term').first.text,
          e.findAllElements('m:Unit').first.text,
          e.findAllElements('m:Mark').first.text,
          e.findAllElements('m:Credits').first.text,
          e.findAllElements('m:Theme').first.text,
          int.parse(e.findAllElements('m:ClassroomLoad').first.text),
          int.parse(e.findAllElements('m:TotalLoad').first.text),
          e.findAllElements('m:TypeOfTheControl').first.text,
        ));
      } else {
        listOfMarks.add(list);
        list = [];
        term = e.findAllElements('m:Term').first.text;
        list.add(MarkRecord(
          e.findAllElements('m:Block').first.text,
          e.findAllElements('m:Subject').first.text,
          DateTime.parse(e.findAllElements('m:Date').first.text),
          e.findAllElements('m:Term').first.text,
          e.findAllElements('m:Unit').first.text,
          e.findAllElements('m:Mark').first.text,
          e.findAllElements('m:Credits').first.text,
          e.findAllElements('m:Theme').first.text,
          int.parse(e.findAllElements('m:ClassroomLoad').first.text),
          int.parse(e.findAllElements('m:TotalLoad').first.text),
          e.findAllElements('m:TypeOfTheControl').first.text,
        ));
      }
    }
    return listOfMarks;
  }

  Future<List<Map<String, Discipline>>> getCurriculumLoad(curriculumId) async {
    var responceTerms = await http.post(server,
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'Content-Type': 'application/xml',
        },
        body: query.getCurriculumTermsQuery(curriculumId));
    var resultTerms = xml.parse(responceTerms.body);

    var termsCount =
        int.parse(resultTerms.findAllElements('m:TermNumber').last.text);
    List<Term> termList = [];
    for (var term in resultTerms.findAllElements('m:Term')) {
      termList.add(Term(
        term.findElements('m:TermId').first.text,
        term.findElements('m:TermName').first.text,
        int.parse(term.findElements('m:TermNumber').first.text),
      ));
    }
    List<Map<String, Discipline>> list = [];

    for (int i = 1; i <= termsCount; i++) {
      var responceLoad = await http.post(server,
          headers: {
            'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
            'Content-Type': 'application/xml',
          },
          body: query.getCurriculumLoadQuery(curriculumId, termList[i - 1].id));
      var resultLoad = xml.parse(responceLoad.body);
      Map<String, Discipline> mapOfDiscipline = {};
      for (var e in resultLoad.findAllElements('m:CurriculumLoad')) {
        if (mapOfDiscipline[e.findElements('m:Subject').first.text] == null) {
          mapOfDiscipline[e.findElements('m:Subject').first.text] = Discipline(
              e.findElements('m:Subject').first.text,
              e.findElements('m:Term').first.text,
              '',
              false,
              0,
              0,
              0, Colors.black);
        }


        switch (e.findElements('m:LoadType').first.text) {
          case 'Лабораторные':
            mapOfDiscipline[e.findElements('m:Subject').first.text].labHours =
                int.parse(e.findElements('m:Amount').first.text);
            break;
          case 'Практические':
            mapOfDiscipline[e.findElements('m:Subject').first.text].pracHours =
                int.parse(e.findElements('m:Amount').first.text);
            break;
          case 'Лекции':
            mapOfDiscipline[e.findElements('m:Subject').first.text].lecHours =
                int.parse(e.findElements('m:Amount').first.text);
            break;
          case 'Экзамен':
            mapOfDiscipline[e.findElements('m:Subject').first.text].type =
                'Экзамен';
            mapOfDiscipline[e.findElements('m:Subject').first.text].color =
            Colors.red;
            break;
          case 'Зачет':
            mapOfDiscipline[e.findElements('m:Subject').first.text].type =
                'Зачет';
            mapOfDiscipline[e.findElements('m:Subject').first.text].color =
            Colors.deepPurple;
            break;
          case 'Курсовая работа':
            mapOfDiscipline[e.findElements('m:Subject').first.text].isControl =
                true;
            break;
        }
      }
      list.add(mapOfDiscipline);
    }
    return list;
  }
}
