
import 'package:delivery_app/models/menu_item_model.dart';

class Restaurant{

  int id;
  String name;
  double rating;
  String imageUrl;
  List<Schedule> scheduleList;
 // List<MenuItem> menuItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.scheduleList
  });

  factory Restaurant.fromJson(Map<String, dynamic> json){
    var list = json['schedule_set'] as List;
    //print(list[);
    List<Schedule> _scheduleList = list.map((schedule) => Schedule.fromJson(schedule)).toList();
    return Restaurant(
        id : json["id"] as int,
        name : json["title"] as String,
        rating : json["rating"] as double,
        imageUrl : json["image"] as String,
        scheduleList : _scheduleList,
    );
  }
}

class Schedule{
  int id;
  String start_weekday;
  String end_weekday;
  String started_at;
  String ended_at;

  Schedule({
    required this.id,
    required this.start_weekday,
    required this.started_at,
    required this.end_weekday,
    required this.ended_at
  });

  factory Schedule.fromJson(Map<String, dynamic> json){
    return Schedule(
        id: json["id"] as int,
        start_weekday: json["start_weekday"] as String,
        started_at: json["started_at"] as String,
        end_weekday: json["end_weekday"] as String,
        ended_at: json["ended_at"] as String);
  }

}