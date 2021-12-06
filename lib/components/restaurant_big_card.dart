import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/screens/details_screen.dart';
import 'package:flutter/material.dart';

class RestaurantBigCard extends StatelessWidget {

  final Restaurant restaurant;

  RestaurantBigCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width-34,
        //color: Colors.grey,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DetailScreen(restaurant: restaurant);
                  }
              ));
            },
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Ink.image(
                    image: NetworkImage("https://rb.gy/ib6ugd"),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            Text(restaurant.rating.toString()),
                            SizedBox(width: 5,),
                            Icon(Icons.taxi_alert_outlined),
                            Text("500T"),
                            SizedBox(width: 5),
                            Icon(Icons.location_on),
                            Text(
                                "${restaurant.address.text_address}"
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
