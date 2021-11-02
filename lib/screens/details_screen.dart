import 'package:delivery_app/models/menu_item_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // List<MenuItem> menuItems = [
  //   MenuItem(id:1, name: "4 Seasons Pizza", price: 2500, text: ''),
  //   MenuItem(id:2, name: "Margarita", price: 1500, text: ''),
  //   MenuItem(id:3, name: "Pepperoni", price: 2000, text: ''),
  //   MenuItem(id:4, name: "Kazakh Burger", price: 950, text: ''),
  //   MenuItem(id:5, name: "Cheeseburger", price: 950, text: ''),
  // ];

  //ScrollController scrollController = ScrollController();
  //bool isTopContainerClosed = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   scrollController.addListener(() {
  //     setState(() {
  //       isTopContainerClosed = scrollController.offset > 50;
  //     });
  //   });
  // }


  NetworkHelper networkHelper = NetworkHelper(
      url:
      "https://fast-cliffs-74827.herokuapp.com/api/restaurants/1/?format=json");
  List<Restaurant> _restaurantList = [];
  List<MenuItem> _menuItemsList = [];
  @override
  void initState() {
    // TODO: implement initState
  //  super.initState();
    networkHelper.getRestaurant().then((value) {
      setState(() {
        _restaurantList.addAll(value);
      });
    });
    networkHelper.getMenu().then((value) {
      setState(() {
        _menuItemsList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var topContainerHeight = height * 0.4;

    return Scaffold(
      body: Column(
        children: [
          // AnimatedContainer(
          //   duration: Duration(milliseconds: 200),
          //   alignment: Alignment.topCenter,
          //   width: width,
          //   height: isTopContainerClosed ? 0 : topContainerHeight,
          //   child: DetailsTopContainer(),
          // ),
          DetailsTopContainer(),
          Expanded(
              child: ListView.builder(
                 // controller: scrollController,
                  itemCount: _menuItemsList.length,
                  itemBuilder: (context, index) {
                    return MenuItemContainer(menuItem: _menuItemsList[index]);
                  }))
        ],
      ),
    );
  }
}

class MenuItemContainer extends StatelessWidget {
  MenuItem menuItem;

  MenuItemContainer({Key? key, required this.menuItem,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage("https://rb.gy/ib6ugd"),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                menuItem.name,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text('${menuItem.price}₸',
                      style: TextStyle(
                          fontSize: 18, color: Colors.amber)),
                  SizedBox(width: 35,),
                  MaterialButton(
                    height: 30,
                    minWidth: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.amber,
                    child: const Text('Add', style: TextStyle(fontSize: 18,color: Colors.white),),
                    onPressed: () => {},
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DetailsTopContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  image: new NetworkImage("https://rb.gy/ib6ugd"),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 15,
            child: MaterialButton(
              height: 30,
              minWidth: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: const Color.fromRGBO(255, 255, 255, 0.7),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            )),
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
             Text(
              'SDU Pizzeria',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: const [
                Icon(Icons.location_on, size: 20, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Kaskelen',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            )
          ]),
        ),
        Positioned(
            right: 20.0,
            bottom: 30.0,
            child: Row(
              children: const [
                Text(
                  "4.6",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            ))
      ],
    );
  }
}
