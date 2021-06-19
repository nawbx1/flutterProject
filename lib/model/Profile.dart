import 'package:doctor_pro/model/Competence.dart';
import 'package:doctor_pro/model/Experience.dart';
import 'package:doctor_pro/model/ImageModel.dart';
import 'package:doctor_pro/model/Region.dart';

class Profile {


  final List<Competence> competences;
  final List<Experience> experiences;
  final List<Region> regions;
  final ImageModel coverImage;
  final ImageModel profileImage;
  final int id;
  final String information;

/*
  Profile.name(this.competences, this.experiences, this.regions,
      this.coverImage, this.profileImage, this.id, this.information);

*/

  Profile({
    this.competences, this.experiences, this.regions, this.coverImage,
    this.profileImage, this.id, this.information,
  });



  factory Profile.fromJson(Map<String, dynamic> jsonMap) {
    return Profile(
        competences: jsonMap['competences'],
        experiences: jsonMap['experiences'],
        regions: jsonMap['regions'],
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
      'cover_image_id': ImageModel().toJson(p.coverImage),
      'profileImage_id': ImageModel().toJson(p.profileImage),
      'experiences':exp,
      'competences':c,
      'regions':reg,
    };return json ;
  }


}



