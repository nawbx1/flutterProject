class Media {
  final int id;

  final String type;

  final String label;

  final String fileName;

  final dynamic file;

  final String mediaURL;

  Media({this.id, this.type, this.label, this.fileName, this.file,
    this.mediaURL});

  factory Media.fromJson(Map<String, dynamic> jsonMap) {
    return Media(
        id: jsonMap['id'],
        type: jsonMap['type'],
        label: jsonMap['label'],
        file: jsonMap['file'],
        fileName: jsonMap['fileName'],
        mediaURL: jsonMap['mediaURL']
    );
  }
}