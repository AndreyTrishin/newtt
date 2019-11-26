import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timetable_app/Models/Discipline.dart';
import 'package:timetable_app/Models/MarkRecord.dart';
import 'package:timetable_app/Models/ScheduleElement.dart';
import 'package:timetable_app/Models/Term.dart';
import 'package:timetable_app/Models/Universe.dart';
import 'package:timetable_app/Query.dart';
import 'package:xml/xml.dart' as xml;

import 'Models/User.dart';

class APIRequest {
  static String getServer(id) {
    return 'http://81.177.140.25/$id/Study.1cws';
  }

  static int idServer;
  static String server;

  static Future<User> authorisation(name, password) async {
    server = getServer(idServer);

    User user;
    var responseAuth;
    try{
      responseAuth = await http.post(server,
          headers: {
            'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
            'SOAPAction': 'http://sgu-infocom.ru/study#WebStudy:Authorization',
            'Content-Type': 'text/xml;charset=UTF-8',
          },
          body: Query.getAutorizationQuery(
              name, sha1.convert(utf8.encode(password)))).timeout(Duration(seconds: 4));
    } catch (_){
      user = null;
    }

    var resultAuth = xml.parse(responseAuth.body);
    try {
      http.Response responseRecBook;
      xml.XmlDocument resultRecBook;
      responseRecBook = await http.post(server,
          headers: {
            'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
            'Content-Type': 'application/xml',
          },
          body: Query.getRecordbooksQuery(
              resultAuth.findAllElements('m:UserId').first.text));
      resultRecBook = xml.parse(responseRecBook.body);
      List<String> roles = [];
      for (var e in resultAuth
          .findAllElements('m:User')
          .first
          .findAllElements('m:Roles')) {
        roles.add(e.findElements('m:Role').first.text);
      }
      if (roles.length == 1) {
        user = User(
            resultAuth.findAllElements('m:UserId').first.text,
            resultAuth.findAllElements('m:Login').first.text,
            resultAuth.findAllElements('m:PasswordHash').first.text,
            idServer.toString(),
            resultRecBook.findAllElements('m:RecordbookId').first.text,
            resultRecBook.findAllElements('m:CurriculumId').first.text,
            resultRecBook.findAllElements('m:CurriculumName').first.text,
            resultRecBook.findAllElements('m:AcademicGroupName').first.text,
            resultRecBook
                .findAllElements('m:AcademicGroupCompoundKey')
                .first
                .text,
            resultRecBook.findAllElements('m:SpecialtyName').first.text,
            'Обучающийся',
            ['Student']);
      } else {
        user = User(
            resultAuth.findAllElements('m:UserId').first.text,
            resultAuth.findAllElements('m:Login').first.text,
            resultAuth.findAllElements('m:PasswordHash').first.text,
            idServer.toString(),
            resultRecBook.findAllElements('m:RecordbookId').first.text,
            resultRecBook.findAllElements('m:CurriculumId').first.text,
            resultRecBook.findAllElements('m:CurriculumName').first.text,
            resultRecBook.findAllElements('m:AcademicGroupName').first.text,
            resultRecBook.findAllElements('m:AcademicGroupCompoundKey').first.text,
            resultRecBook.findAllElements('m:SpecialtyName').first.text,
            null,
            roles);
      }
    } catch (_) {
      try {
        user = User(
          resultAuth.findAllElements('m:UserId').first.text,
          resultAuth.findAllElements('m:Login').first.text,
          resultAuth.findAllElements('m:PasswordHash').first.text,
          idServer.toString(),
          null, null, null, null, null, null,
          'Преподаватель',
          ['Teacher'],
        );
      } catch (_) {
        user = User(null, 'Ошибка', null, null);
      }
    }
    return user;
  }

  static Future<List<List<MarkRecord>>> getEducationalPerformance(
      userId, recbookId) async {
    http.Response response;
    List<List<MarkRecord>> listOfMarks = [];
    try{
      response = await http.post(getServer(idServer),
          headers: {
            'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
            'Content-Type': 'application/xml',
          },
          body: Query.getEducationalPerformance(userId, recbookId)).timeout(Duration(seconds: 5));
    } catch(_){
      listOfMarks = null;
    }

    var result = xml.parse(response.body);

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
      } else if (e != null) {
        if(e.findAllElements('m:Term').first.text != ''){
          listOfMarks.add(list);
          term = e.findAllElements('m:Term').first.text;
          list = [];
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

      } else {
        listOfMarks.add(list);
      }
    }
    listOfMarks.add(list);
    return listOfMarks;
  }

  static Future<List<List<Discipline>>> getCurriculumLoad(curriculumId) async {
    List<Term> termList = [];
    http.Response responseTerms;
    try{
      responseTerms = await http.post(getServer(idServer),
          headers: {
            'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
            'Content-Type': 'application/xml',
          },
          body: Query.getCurriculumTermsQuery(curriculumId)).timeout(Duration(seconds: 5));
    } catch (_){
      termList = null;
    }

    var resultTerms = xml.parse(responseTerms.body);



    var termsCount =
        int.parse(resultTerms.findAllElements('m:TermNumber').last.text);
    for (var term in resultTerms.findAllElements('m:Term')) {
      termList.add(Term(
        term.findElements('m:TermId').first.text,
        term.findElements('m:TermName').first.text,
        int.parse(term.findElements('m:TermNumber').first.text),
      ));
    }
    List<List<Discipline>> list = [];

    for (int i = 1; i <= termsCount; i++) {
      http.Response responseLoad;
      try{
        responseLoad = await http.post(getServer(idServer),
            headers: {
              'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
              'Content-Type': 'application/xml',
            },
            body: Query.getCurriculumLoadQuery(curriculumId, termList[i - 1].id)).timeout(Duration(seconds: 5));
      } catch (_){
        termList = null;
      }

      var resultLoad = xml.parse(responseLoad.body);
      Map<String, Discipline> mapOfDiscipline = {};
      for (var e in resultLoad.findAllElements('m:CurriculumLoad')) {
        if (mapOfDiscipline[e.findElements('m:Subject').first.text] == null) {
          mapOfDiscipline[e.findElements('m:Subject').first.text] = Discipline(
              e.findElements('m:Subject').first.text,
              e.findElements('m:Term').first.text,
              '',
              false,
              [],
              Colors.black);
        }

        switch (e.findElements('m:LoadType').first.text) {
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
          default:
            mapOfDiscipline[e.findElements('m:Subject').first.text].load.add(MLoad(e.findElements('m:LoadType').first.text, int.parse(e.findElements('m:Amount').first.text)));
            break;
        }
      }
      List<Discipline> disciplineList = mapOfDiscipline.values.toList();

      disciplineList.sort((a, b) => b.type.compareTo(a.type));
      list.add(disciplineList);
    }
    return list;
  }

  static Future<ScheduleElement> getSchedule(key, date) async {
    var response = await http.post(getServer(idServer),
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'Content-Type': 'application/xml',
        },
        body: Query.getScheduleQuery(key, date, 'AcademicGroup'));
    ScheduleElement scheduleElement;
//    dio = Dio();


//    var response = await dio.post(getServer(idServer), data: Query.getScheduleQuery(key, date, 'AcademicGroup'), );
    var result = xml.parse(response.body);


    List<ScheduleCell> lessonList = [];
    try {
      for (var e in result.findAllElements('m:ScheduleCell')) {
        var lesson = e.findElements('m:Lesson');
        Color color;
        if (lesson.isNotEmpty) {
          switch (e.findElements('m:Lesson').first.findElements('m:LessonType').first.text) {
            case 'Лекции':
              color = Color.fromARGB(255, 0, 164, 116);
              break;
            default:
              color = Color.fromARGB(255, 48, 74, 197);
              break;
          }
//        print(e.findElements('m:Lesson').first.findElements('m:LessonType').first.text);
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              Lesson(
                  e.findAllElements('m:LessonCompoundKey').first.text,
                  e.findElements('m:Lesson').first.findElements('m:Subject').first.text,
                  e.findElements('m:Lesson').first.findElements('m:LessonType').first.text,
                  Teacher(e.findElements('m:Lesson').first.findElements('m:Teacher').first.findElements('m:TeacherId').first.text,
                      e.findElements('m:Lesson').first.findElements('m:Teacher').first.findElements('m:TeacherName').first.text),
                  e.findElements('m:Lesson').first.findElements('m:Classroom')
                          .isNotEmpty
                      ? Classroom(
                          e
                              .findElements('m:Lesson')
                              .first
                              .findElements('m:Classroom')
                              .first
                              .findElements('m:ClassroomUID')
                              .first
                              .text,
                          e
                              .findElements('m:Lesson')
                              .first
                              .findElements('m:Classroom')
                              .first
                              .findElements('m:ClassroomName')
                              .first
                              .text)
                      : null,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findAllElements('m:AcademicGroupName')
                      .first
                      .text,
                  color)));
        } else {
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              null));
        }
      }
      scheduleElement = ScheduleElement(
          result
              .findAllElements('m:Day')
              .first
              .findAllElements('m:Date')
              .first
              .text,
          result.findAllElements('m:DayOfWeek').first.text,
          lessonList);
    } catch (_) {
      scheduleElement = ScheduleElement(date, '', null);
    }



    return scheduleElement;
  }

  static Future<List<University>> getUnivercity() async {
    var response = await http.get('http://81.177.140.25/university.xml');

    var result = xml.parse(utf8.decode(response.bodyBytes));

    List<University> list = [];

    for (var e in result.findAllElements('university')) {
      list.add(University(
        int.parse(e.findAllElements('id').first.text),
        e.findAllElements('name').first.text,
        e.findAllElements('city').first.text,
      ));
    }
    return list;
  }

  static getTeacherSchedule(idUser, date) async {
    var response = await http.post(getServer(idServer),
        headers: {
          'Authorization': 'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6',
          'Content-Type': 'application/xml',
        },
        body: Query.getScheduleQuery(idUser, date, 'Teacher'));

    var result = xml.parse(response.body);
    ScheduleElement scheduleElement;

    List<ScheduleCell> lessonList = [];
    try {
      for (var e in result.findAllElements('m:ScheduleCell')) {
        var lesson = e.findElements('m:Lesson');
        Color color;
        if (lesson.isNotEmpty) {
          switch (e
              .findElements('m:Lesson')
              .first
              .findElements('m:LessonType')
              .first
              .text) {
            case 'Лекции':
              color = Color.fromARGB(255, 0, 164, 116);
              break;
            case 'Практические':
              color = Color.fromARGB(255, 48, 74, 197);
              break;
            case 'Курсовой проект':
              color = Color.fromARGB(255, 48, 74, 197);
              break;
            case 'Лабораторные':
              color = Color.fromARGB(255, 48, 74, 197);
              break;
            case 'Обучение':
              color = Color.fromARGB(255, 48, 74, 197);
              break;
            case 'Зачет':
              color = Color.fromARGB(255, 48, 74, 197);
              break;
          }
//        print(e.findElements('m:Lesson').first.findElements('m:LessonType').first.text);
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              Lesson(
                  e.findAllElements('m:LessonCompoundKey').first.text,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findElements('m:Subject')
                      .first
                      .text,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findElements('m:LessonType')
                      .first
                      .text,
                  Teacher(
                      e
                          .findElements('m:Lesson')
                          .first
                          .findElements('m:Teacher')
                          .first
                          .findElements('m:TeacherId')
                          .first
                          .text,
                      e
                          .findElements('m:Lesson')
                          .first
                          .findElements('m:Teacher')
                          .first
                          .findElements('m:TeacherName')
                          .first
                          .text),
                  null,
                  e
                      .findElements('m:Lesson')
                      .first
                      .findAllElements('m:AcademicGroupName')
                      .first
                      .text,
                  color)));
        } else {
          lessonList.add(ScheduleCell(
              DateTime.parse(e.findElements('m:DateBegin').first.text),
              DateTime.parse(e.findElements('m:DateEnd').first.text),
              null));
        }
      }
      scheduleElement = ScheduleElement(
          result
              .findAllElements('m:Day')
              .first
              .findAllElements('m:Date')
              .first
              .text,
          result.findAllElements('m:DayOfWeek').first.text,
          lessonList);
    } catch (_) {
      scheduleElement = ScheduleElement(date, '', null);
    }

    return scheduleElement;
  }
}
