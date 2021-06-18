
import 'dart:convert';

import 'package:doctor_pro/model/Speciality.dart';
import 'package:doctor_pro/repository/UserRepository.dart';

class UserBloc{

  UserRepository userRepository = new  UserRepository();


  UserBloc();

  Future<List<Speciality>> fetchSpeciality() async {
    print("userbloc   ..... ");

    var result = await userRepository.fetchSpeciality() ;
    print("result is");
    var  res = json.decode(result.body.toString()) as List;
    print(res.length);
    print(res[1]);
    print("result is 2");
    List<Speciality> lists = res.map((tagJson) => Speciality.fromJson(tagJson)).toList();


print(lists.toString());
    print("result is 3");
    print(res[0]);
    return result.statusCode==200? lists : [];
  }


}