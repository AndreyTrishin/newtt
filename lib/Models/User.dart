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
  List<String> roles;
  String server;


  User(
      this.id,
      this.name,
      this.password,
      this.server,
      [this.recordbookId,
      this.curriculumId,
      this.curriculumName,
      this.academicGroupName,
      this.academicGroupCompoundKey,
      this.specialtyName,
      this.currentRole, this.roles]);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        password = json['password'],
        server = json['server'],
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
        'server': server,
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
    return '$id, $name, $password, $recordbookId, $specialtyName, $roles, $server';
  }


}
