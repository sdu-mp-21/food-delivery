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