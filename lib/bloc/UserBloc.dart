
import 'dart:convert';

import 'package:doctor_pro/model/Speciality.dart';
import 'package:doctor_pro/repository/UserRepository.dart';

class UserBloc{

  UserRepository userRepository = new  UserRepository();


  UserBloc();

  Future<List<Speciality>> fetchSpeciality() async {
    print("userbloc   ..... ");

    var result = await userRepository.fetchSpeciality().then((value) => {

    print("result is")
        var res= json.decode(value.body);
    print("result is 2");
    print(res);
    return value.statusCode==200? res : [];
    });

  }


}