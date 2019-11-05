class Query {
  getAutorizationQuery(name, password) {
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

  getRecordbooksQuery(id) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetRecordbooks>
            <stu:UserId>$id</stu:UserId>
        </stu:GetRecordbooks>
    </x:Body>
</x:Envelope>''';
  }

  getEducationalPerformance(userId, recbookId) {
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

  getCurriculumLoadQuery(curriculumId, termId) {
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

  getCurriculumTermsQuery(curriculumId) {
    return '''<x:Envelope xmlns:x="http://schemas.xmlsoap.org/soap/envelope/" xmlns:stu="http://sgu-infocom.ru/study">
    <x:Header/>
    <x:Body>
        <stu:GetCurriculumTerms>
            <stu:CurriculumId>$curriculumId</stu:CurriculumId>
        </stu:GetCurriculumTerms>
    </x:Body>
</x:Envelope>''';
  }
}
