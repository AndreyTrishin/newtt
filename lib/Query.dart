class Query {
  static getAutorizationQuery(name, password) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:Authorization>
            <stu:UserId></stu:UserId>
            <stu:Login>$name</stu:Login>
            <stu:PasswordHash>$password</stu:PasswordHash>
        </stu:Authorization>
    </x:Body>
</x:Envelope>''';
  }

  static getRecordbooksQuery(id) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetRecordbooks>
            <stu:UserId>$id</stu:UserId>
        </stu:GetRecordbooks>
    </x:Body>
</x:Envelope>''';
  }

  static getEducationalPerformance(userId, recbookId) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetEducationalPerformance>
            <stu:UserId>$userId</stu:UserId>
            <stu:RecordbookId>$recbookId</stu:RecordbookId>
        </stu:GetEducationalPerformance>
    </x:Body>
</x:Envelope>''';
  }

  static getCurriculumLoadQuery(curriculumId, termId) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetCurriculumLoad>
            <stu:CurriculumId>$curriculumId</stu:CurriculumId>
            <stu:TermId>$termId</stu:TermId>
        </stu:GetCurriculumLoad>
    </x:Body>
</x:Envelope>''';
  }

  static getCurriculumTermsQuery(curriculumId) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetCurriculumTerms>
            <stu:CurriculumId>$curriculumId</stu:CurriculumId>
        </stu:GetCurriculumTerms>
    </x:Body>
</x:Envelope>''';
  }

  static getScheduleQuery(key, date) {
    return '''<Envelope xmlns="http://www.w3.org/2003/05/soap-envelope">
       <Body>
          <GetSchedule xmlns="http://sgu-infocom.ru/study">
             <DateBegin>$date</DateBegin>
             <DateEnd>$date</DateEnd>
             <RecordbookRef></RecordbookRef>
             <ScheduleObjectId>$key</ScheduleObjectId>
             <ScheduleObjectType>AcademicGroup</ScheduleObjectType>
             <ScheduleType>Full</ScheduleType>
             <UserRef></UserRef>
          </GetSchedule>
       </Body>
    </Envelope>''';
  }
}
