import 'package:delivery_app/models/cart_model.dart';
import 'package:delivery_app/models/address_model.dart';

class Order {
  final int id;
  final int price;
  final int delivery_price;
  final int persons_count;
  final int restaurant;
  final int user;
  final int address;

  //final List<CartItem> food_set;

  Order({
    required this.id,
    required this.price,
    required this.delivery_price,
    required this.persons_count,
    required this.restaurant,
    required this.user,
    required this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["id"],
      price : json["price"] as int,
      delivery_price : json["delivery_price"],
      persons_count : json["persons_count"],
      restaurant : json["restaurant"],
      user: json["user"],
      address: json["address"],
    );
  }

}