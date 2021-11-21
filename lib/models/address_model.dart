class Address {
  int id;
  String text_address;
  String comment;
  double latitude;
  double longitude;

  Address({required this.id, required this.latitude, required this.longitude, required this.text_address, required this.comment});

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