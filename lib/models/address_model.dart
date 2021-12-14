class Address {
  int? id;
  String text_address;
  String? comment;
  double latitude;
  double longitude;

  Address({this.id, required this.latitude, required this.longitude, required this.text_address, this.comment});

  factory Address.fromJson(Map<String, dynamic> parsedJson){
    return Address(
        id:parsedJson['id'],
        text_address:parsedJson['text_address'],
        comment: parsedJson['comment'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude']
    );
  }
}