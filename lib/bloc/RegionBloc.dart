
import 'dart:convert';

import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/model/Gouvernorat.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/repository/RegionRepository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionBloc{

  RegionRepository regionRepository = new  RegionRepository();

  RegionBloc();
  


  Future<List<Gouvernorat>> fetchGouvernorat() async {
    var result = await regionRepository.fetchGouvernorat() ;
    print("result is");
    var  res = json.decode(result.body.toString())as List;
    List<Gouvernorat> result2 = res.map((i) => Gouvernorat.fromJson(i)).toList();

    return result.statusCode==200? result2 : [];
  }

  Future<List<Region>> fetchRegionByGouvernoartId(int id) async {

    var result = await regionRepository.fetchRegionByGouvernoartId(id) ;
    print("result is");
    var  res = json.decode(result.body.toString())as List;
    List<Region> result2 = res.map((i) => Region.fromJson(i)).toList();

    return result.statusCode==200? result2 : [];
  }









}