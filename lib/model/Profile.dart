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


}



