import 'package:doctor_pro/model/Competence.dart';
import 'package:doctor_pro/model/Experience.dart';
import 'package:doctor_pro/model/ImageModel.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/Region.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Profile.g.dart';
@JsonSerializable()
class Profile {


  final List<Competence> competences;
  final List<Experience> experiences;
  final List<Region> regions;
  final Media coverImage;
  final Media profileImage;
  final int id;
  final String information;


  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);


  @override
  String toString() {
    return 'Profile{competences: $competences, experiences: $experiences, regions: $regions, coverImage: $coverImage, profileImage: $profileImage, id: $id, information: $information}';
  }

  /*
  Profile.name(this.competences, this.experiences, this.regions,
      this.coverImage, this.profileImage, this.id, this.information);

*/

  Profile({
    this.competences, this.experiences, this.regions, this.coverImage,
    this.profileImage, this.id, this.information,
  });


/*

  factory Profile.fromJson(Map<String, dynamic> jsonMap) {
   var c=[];
    if(jsonMap['competences']!=null){
      for(int i=0;i<jsonMap['competences'].length;i++) {
        c.add(  new Competence.fromJson(jsonMap['competences'][i]) );
      }
    }

    var e=[];
    if(jsonMap['experiences']!=null){
      for(int i=0;i<jsonMap['experiences'].length;i++) {
        e.add(  new Experience.fromJson(jsonMap['experiences'][i]) );
      }
    }

    var r=[];
    if(jsonMap['regions']!=null){
      for(int i=0;i<jsonMap['regions'].length;i++) {
        r.add(  new Region.fromJson(jsonMap['regions'][i]) );
      }
    }

    return Profile(
        competences: c,
        experiences: e,
        regions: r,
        coverImage: jsonMap['coverImage'],
        profileImage: jsonMap['profileImage'],
        id: jsonMap['id'],
        information: jsonMap['information'],
    );
  }
  Map<String, dynamic> toJson(Profile p) {
    var c=[];
    if(p.competences!=null){
      for(int i=0;i<p.competences.length;i++) {
        c.add(Competence().toJson(p.competences[i]));
      }
    }

    var exp=[];
    if(p.experiences!=null){
      for(int i=0;i<p.experiences.length;i++) {
        exp.add(Experience().toJson(p.experiences[i]));
      }
    }
    var reg=[];
    if(p.regions!=null){
      for(int i=0;i<p.regions.length;i++) {
        reg.add(Region().toJson(p.regions[i]));
      }
    }



    Map<String, dynamic> json = {
      'id':p.id,
      'information': p.information,
      'cover_image_id':p.coverImage != null ? ImageModel().toJson(p.coverImage) : null,
      'profileImage_id': p.coverImage != null ?  ImageModel().toJson(p.profileImage) :null,
      'experiences':exp,
      'competences':c,
      'regions':reg,
    };return json ;
  }
*/


}



