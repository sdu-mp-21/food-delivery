import 'package:flutter/material.dart';

class Restaurant{

  int id;
  String name;
  int rating;

  Restaurant(this.id, this.name, this.rating);

  Restaurant.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        rating = json['rating'];
}