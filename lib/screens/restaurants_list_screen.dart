import 'package:delivery_app/components/restaurant_big_card.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantsListScreen extends StatelessWidget {
  final List<Restaurant> restaurantsList;
  final String title;

  RestaurantsListScreen({required this.title, required this.restaurantsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: restaurantsList.length,
              itemBuilder: (context, index){
                return RestaurantBigCard(restaurant: restaurantsList[index]);
              }),
        ),
      ),
    );
  }
}
