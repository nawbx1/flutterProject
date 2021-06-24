import 'package:doctor_pro/model/InterventionType.dart';

class DraggableList {
   String header;
   List<InterventionType> items;

   @override
  String toString() {
    return 'DraggableList{ items: $items}';
  }
}

/*
class DraggableListItem {
  final String title;
  final String urlImage;

  const DraggableListItem({
     this.title,
     this.urlImage,
  });
}*/
