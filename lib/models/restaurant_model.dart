import 'package:delivery_app/models/address_model.dart';
import 'package:delivery_app/models/schedule_model.dart';

class Restaurant{

  int id;
  String name;
  double rating;
  String imageUrl;
  List<Schedule> scheduleList;
  Address address;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.scheduleList,
    required this.address
  });

  factory Restaurant.fromJson(Map<String, dynamic> json){
    var list = json['schedule_set'] as List;
    List<Schedule> _scheduleList = list.map((schedule) => Schedule.fromJson(schedule)).toList();
    return Restaurant(
        id : json["id"] as int,
        name : json["title"] as String,
        rating : json["rating"] as double,
        imageUrl : json["image"] as String,
        address: Address.fromJson(json["address"]),

        scheduleList : _scheduleList,
    );
  }
}
