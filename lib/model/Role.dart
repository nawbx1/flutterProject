

import 'package:json_annotation/json_annotation.dart';

part 'Role.g.dart';
@JsonSerializable()
class Role {
   int  id ;
    String name;

  Role({this.id, this.name});

  Role.name(this.name);

   factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

   Map<String, dynamic> toJson() => _$RoleToJson(this);



   /*factory Role.fromJson(Map<String, dynamic> jsonMap) {
    return Role(
        id: jsonMap['id'],
        name: jsonMap['name']
    );
  }
   Map<String, dynamic> toJson(Role m) {

     Map<String, dynamic> json = {
       'id':m.id,

       'name': m.name,
     };return json ;
   }
*/
   @override
  String toString() {
    return 'Role{name: $name}';
  }
}