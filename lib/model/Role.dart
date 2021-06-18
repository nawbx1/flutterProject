class Role {
   int  id ;
    String name;

  Role({this.id, this.name});

  Role.name(this.name);

  factory Role.fromJson(Map<String, dynamic> jsonMap) {
    return Role(
        id: jsonMap['id'],
        name: jsonMap['name']
    );
  }
}