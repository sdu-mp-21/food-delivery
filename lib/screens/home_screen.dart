import 'package:delivery_app/components/restaurant_big_card.dart';
import 'package:delivery_app/models/address_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/screens/cart_screen.dart';
import 'package:delivery_app/screens/details_screen.dart';
import 'package:delivery_app/screens/map_screen.dart';
import 'package:delivery_app/screens/restaurants_list_screen.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/forgot_password.dart';
import 'package:delivery_app/screens/forgot_password_verification.dart';
import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;

  NetworkHelper networkHelper = NetworkHelper(
      url:
          "http://fast-cliffs-74827.herokuapp.com/api/restaurants/?format=json");
  List<Restaurant> _restaurantsList = [];

  List<Address> userAddresses=[
    Address(latitude: 34, longitude: 70, text_address: 'No Address')
  ];

  void updateInformation(Address newAddress) {
    setState(() {
      userAddresses.add(newAddress);
      
    });
  }

  void moveToMapScreen() async {
    final Address userAdress = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => MapScreen(_restaurantsList)),
    );
    updateInformation(userAdress);
  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text('address'),value: 'address'),
    ];
    userAddresses.forEach((address) {
      menuItems.add(
      DropdownMenuItem(child: Text(address.text_address),value: address.text_address),
    );});

    return menuItems;
  }
  var selectedValue = 'No Address';

  @override
  void initState() {
    super.initState();
    networkHelper.getRestaurant().then((value) {
      setState(() {
        _restaurantsList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ])),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    child: Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.0,
                  1.0
                ],
                    colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).accentColor.withOpacity(0.5),
                ])),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Food Delivery',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag_rounded,
                      size: _drawerIconSize, color: Colors.grey.shade800),
                  title: Text(
                    'Food List',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag_rounded,
                      size: _drawerIconSize, color: Colors.grey.shade800),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login_rounded,
                      size: _drawerIconSize, color: Colors.grey.shade800),
                  title: Text(
                    'Login Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt_1,
                      size: _drawerIconSize, color: Colors.grey.shade800),
                  title: Text(
                    'Registration Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.password_rounded,
                    size: _drawerIconSize,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'Forgot Password Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_user_sharp,
                    size: _drawerIconSize,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'Verification Page',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordVerification()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: Colors.grey.shade800,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    // SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                //Deliver to
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Delivering to",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton(
                    value: selectedValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: dropdownItems,
                    // userAddresses.map((address) {
                    //   return DropdownMenuItem(
                    //       value: address.text_address,
                    //       child: Text(address.text_address)
                    //   );
                    // }
                    // ).toList(),

                    onChanged: (String? newValue){
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                  // child: DropdownButtonHideUnderline(
                  //     child: DropdownButton(
                  //       value: selectedValue,
                  //       items: dropdownItems,
                  //       icon: Icon(Icons.arrow_drop_down),
                  //       style: Theme.of(context).textTheme.headline6,
                  //       onChanged: (String? ){
                  //         setState(() {
                  //           selectedValue = newValue!;
                  //         });
                  //       },
                  // )),
                ),
                MaterialButton(
                  onPressed: () => moveToMapScreen(),
                  child: Text("Open in map"),
                ),
                SizedBox(height: 15),

                //Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Color(0xFFF2F2F2),
                    ),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search restaurant",
                              hintStyle:
                              TextStyle(color: Color(0xFFB6B7B7), fontSize: 18)
                          )
                      ),
                      suggestionsCallback: (pattern) => _restaurantsList.where(
                          (item) => item.name
                              .toLowerCase()
                              .contains(pattern.toLowerCase())),
                      itemBuilder: (context, Restaurant restaurant) {
                        return ListTile(
                          title: Text(restaurant.name),
                          leading: Icon(Icons.restaurant),
                        );
                      },
                      onSuggestionSelected: (Restaurant restaurant) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(restaurant: restaurant),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //discount Slider
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      SliderBannerItem(imageUrl: "https://bit.ly/3bPkuH2"),
                      SliderBannerItem(imageUrl: "https://bit.ly/32mO0Td"),
                      SliderBannerItem(imageUrl: "https://bit.ly/3DymC2d"),
                    ]),
                    /*SlideTransition(
                      position: offset,
                      child: Row(children: [
                        SliderBannerItem(imageUrl: "https://bit.ly/3bPkuH2"),
                        SliderBannerItem(imageUrl: "https://bit.ly/32mO0Td"),
                        SliderBannerItem(imageUrl: "https://bit.ly/3DymC2d"),
                      ]),
                    ),*/
                  ),
                ),
                SizedBox(height: 20),

                //popular restaurants list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Restaurants",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantsListScreen(
                                        title: "Popular Restaurants",
                                        restaurantsList: _restaurantsList),
                                  ),
                                )
                              },
                          child: Row(
                            children: [
                              Text("View all"),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Container(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _restaurantsList.length,
                      itemBuilder: (context, index) {
                        return SliderRestaurantCard(
                            restaurant: _restaurantsList[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //new restaurants
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Restaurants",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantsListScreen(
                                        title: "New Restaurants",
                                        restaurantsList:
                                            _restaurantsList.reversed.toList()),
                                  ),
                                )
                              },
                          child: Row(
                            children: [
                              Text("View all"),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Container(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _restaurantsList.length,
                      itemBuilder: (context, index) {
                        return SliderRestaurantCard(
                            restaurant:
                                _restaurantsList.reversed.toList()[index]);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //all restaurants
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "All Restaurants",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 17.0, vertical: 10.0),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _restaurantsList.length,
                        itemBuilder: (context, index) {
                          return RestaurantBigCard(
                              restaurant: _restaurantsList[index]);
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SliderRestaurantCard extends StatelessWidget {
  Restaurant restaurant;

  SliderRestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: SizedBox(
        width: 250,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(restaurant: restaurant);
                }));
              },
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      height: 120.0,
                      child: Ink.image(
                        image: NetworkImage(restaurant.imageUrl),//NetworkImage("https://rb.gy/ib6ugd"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                    ),

                    //working hours
                    Positioned(
                        bottom: 0,
                        right: -1,
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch,
                                color: Color(0xFFB6B7B7),
                              ),
                              Text(
                                "${restaurant.scheduleList[DateTime.now().weekday - 1].started_at.substring(0, 5)}-${restaurant.scheduleList[DateTime.now().weekday - 1].ended_at.substring(0, 5)}",
                                style: TextStyle(color: Color(0xFF6D6D6D)),
                              ),
                            ],
                          ),
                        )),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            Text(restaurant.rating.toString()),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.taxi_alert_outlined),
                            Text("500T"),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class SliderBannerItem extends StatelessWidget {
  String imageUrl;

  SliderBannerItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          height: 100,
          child: Image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  final List<Restaurant> restaurantList;

  SearchBar(this.restaurantList);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {},
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      );

  @override
  Widget buildResults(BuildContext context) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city,
            size: 120,
          ),
          const SizedBox(
            height: 48,
          ),
          Text(query)
        ],
      ));

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggetions = restaurantList;

    return buildSuggestionSuccess(suggetions);
  }

  Widget buildSuggestionSuccess(List<Restaurant> suggetions) =>
      ListView.builder(
          itemCount: suggetions.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.location_city),
              title: Text(suggetions[index].name),
            );
          });
}
