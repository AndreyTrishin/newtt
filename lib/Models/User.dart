class User {
  String id;
  String name, password;
  String recordbookId;
  String curriculumId;
  String curriculumName;
  String academicGroupName;
  String academicGroupCompoundKey;
  String specialtyName;
  String currentRole;

  User(
      this.id,
      this.name,
      this.password,
      this.recordbookId,
      this.curriculumId,
      this.curriculumName,
      this.academicGroupName,
      this.academicGroupCompoundKey,
      this.specialtyName,
      [this.currentRole]);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        password = json['password'],
        recordbookId = json['recordbookId'],
        curriculumId = json['curriculumId'],
        curriculumName = json['curriculumName'],
        academicGroupName = json['academicGroupName'],
        academicGroupCompoundKey = json['academicGroupCompoundKey'],
        specialtyName = json['specialtyName'],
        currentRole = json['currentRole'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'recordbookId': recordbookId,
        'curriculumId': curriculumId,
        'curriculumName': curriculumName,
        'academicGroupName': academicGroupName,
        'academicGroupCompoundKey': academicGroupCompoundKey,
        'specialtyName': specialtyName,
        'currentRole': currentRole,
      };

  @override
  String toString() {
    return '$id, $name, $password, $recordbookId, $specialtyName';
  }


}
