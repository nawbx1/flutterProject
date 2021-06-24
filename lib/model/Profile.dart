import 'package:doctor_pro/model/Competence.dart';
import 'package:doctor_pro/model/Experience.dart';
import 'package:doctor_pro/model/ImageModel.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/Region.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Profile.g.dart';
@JsonSerializable()
class Profile {


   List<Competence> competences;
   List<Experience> experiences;
   List<Region> regions;
   Media coverImage;
   Media profileImage;
   int id;
   String information;


  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);


  @override
  String toString() {
    return 'Profile{competences: $competences, experiences: $experiences, regions: $regions, coverImage: $coverImage, profileImage: $profileImage, id: $id, information: $information}';
  }
  

  Profile({
    this.competences, this.experiences, this.regions, this.coverImage,
    this.profileImage, this.id, this.information,
  });


  
}



