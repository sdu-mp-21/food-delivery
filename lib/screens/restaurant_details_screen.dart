import 'dart:convert';

import 'package:delivery_app/models/menu_item_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  //RestaurantDetailsScreen(this.id);

  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  int id = 1;
  List<String> menuSections = ["Pizza", "Burger", "Drinks", "Snacks", "Sauces"];
  // List<MenuItem> menuItems = [
  //   MenuItem(name:"4 Seasons Pizza",price:2500),
  //   MenuItem(name:"Margarita",price:1500),
  //   MenuItem(name:"Pepperoni",price:2000),
  //   MenuItem(name:"Kazakh Burger",price:950),
  //   MenuItem(name:"Cheeseburger",price:950),
  // ];

  NetworkHelper networkHelper = NetworkHelper(
      url:
          "https://fast-cliffs-74827.herokuapp.com/api/restaurants/?format=json");
  List<Restaurant> _restaurantList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkHelper.getRestaurant().then((value) {
      setState(() {
        _restaurantList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: (() {
        //displaying loading while receiving data from api
        if (_restaurantList.isEmpty) {
          return const Center(
            child: Text('Loading...'),
          );
        } else {
          return SlidingUpPanel(
            maxHeight: height,
            minHeight: height / 1.6,
            panel: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _restaurantList[id].name,
                        //'SDU Pizzeria',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(_restaurantList[id].rating.toString(),
                              //'4.6',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kaskelen 1.4km \$\$",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menuSections.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 100,
                            child: Text(
                              menuSections[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300]),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   height: height,
                  //
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: menuItems.length,
                  //       itemBuilder: (context,index){
                  //     return Container(
                  //         height: 80,
                  //
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               menuItems[index].name,
                  //               style: TextStyle(fontWeight: FontWeight.bold),
                  //             ),
                  //             Text(
                  //               menuItems[index].price.toString(),
                  //               style: TextStyle(fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         )
                  //
                  //     );
                  //   }),
                  // )
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            menuItemtab("https://rb.gy/ib6ugd", "Classic",
                                "Tamota sauce, cheese", "6.99"),
                            menuItemtab("https://rb.gy/ib6ugd", "Americana",
                                "Base + Peperani", "7.99"),
                            menuItemtab("https://rb.gy/ib6ugd", "Vegetarian",
                                "Onion and Corn", "4.99"),
                            menuItemtab("https://rb.gy/ib6ugd", "Classic",
                                "Tamota sauce, cheese", "6.99"),
                            menuItemtab("https://rb.gy/ib6ugd", "Americana",
                                "Base + Peperani", "7.99"),
                            menuItemtab("https://rb.gy/ib6ugd", "Vegetarian",
                                "Onion and Corn", "4.99"),
                          ],
                        )),
                  )
                ],
              ),
            ),
            body: Container(
              height: height / 2,
              width: width,
              alignment: Alignment.topCenter,
              child: Stack(children: [
                Image(
                  image: NetworkImage("https://rb.gy/ib6ugd"),
                  fit: BoxFit.cover,
                  height: height / 2.5,
                  width: width,
                ),
                Positioned(
                    top: 40,
                    left: 15,
                    child: MaterialButton(
                      height: 30,
                      minWidth: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                    ))
              ]),
            ),
            borderRadius: BorderRadius.circular(25),
          );
        }
      }())),
    );
  }

  Widget menuItemtab(
      String pizzaImage, String pizza, String ingredients, String price) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Container(
        height: 100.0,
        width: width - 20.0,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Container(
                padding: EdgeInsets.only(left: 70.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                height: 100.0,
                width: width - 90.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pizza,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          ingredients,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Text("\$$price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 15.0))
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0.0,
                child: Image(
                  image: NetworkImage(pizzaImage),
                  height: 100.0,
                  width: 100.0,
                ))
          ],
        ),
      ),
    );
  }
}
//                  image: NetworkImage("https://rb.gy/ib6ugd"),
