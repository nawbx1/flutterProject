class Role {
  final int  id ;
  final  String name;

  Role({this.id, this.name});
  factory Role.fromJson(Map<String, dynamic> jsonMap) {
    return Role(
        id: jsonMap['id'],
        name: jsonMap['name']
    );
  }
}