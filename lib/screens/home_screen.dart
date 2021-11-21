import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/screens/details_screen.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/forgot_password.dart';
import 'package:delivery_app/screens/forgot_password_verification.dart';
import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

   NetworkHelper networkHelper = NetworkHelper(
       url:
       "http://fast-cliffs-74827.herokuapp.com/api/restaurants/?format=json");
   List<Restaurant> _restaurantsList = [];

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
          title: Text("Profile",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace:Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                )
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only( top: 16, right: 16,),
              child: Stack(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                    },
                    child: Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                        constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                        child: Text( '1', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                      ),
                    ),)

                ],
              ),
            )
          ],
        ),

        drawer: Drawer(
          child: Container(
            decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      Theme.of(context).accentColor.withOpacity(0.5),
                    ]
                )
            ) ,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text('Food Delivery',
                      style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_bag_rounded ,size: _drawerIconSize,color: Colors.grey.shade800),
                  title: Text('Food List', style: TextStyle(fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Colors.grey.shade800),
                  title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Colors.grey.shade800),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Colors.grey.shade800),
                  title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.grey.shade800),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUp()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Colors.grey.shade800,),
                  title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.grey.shade800),),
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPassword()),);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Colors.grey.shade800,),
                  title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.grey.shade800),),
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerification()), );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Colors.grey.shade800,),
                  title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Colors.grey.shade800),),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Delivering to",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                value: "current location",
                items: [
                  DropdownMenuItem(
                    child: Text("Current Location"),
                    value: "current location",
                  ),
                ],
                icon: Icon(Icons.arrow_drop_down),
                style: Theme.of(context).textTheme.headline6,
                onChanged: (_) => {},
              )),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xFFF2F2F2),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search food",
                      hintStyle:
                          TextStyle(color: Color(0xFFB6B7B7), fontSize: 18)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  SliderBannerItem(imageUrl: "https://bit.ly/3bPkuH2"),
                  SliderBannerItem(imageUrl: "https://bit.ly/3bPkuH2"),
                  SliderBannerItem(imageUrl: "https://bit.ly/3bPkuH2"),
                ]),
              ),
            ),
            SizedBox(height: 30),
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
                      onPressed: () => {},
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _restaurantsList.length,
                  itemBuilder: (context,index){
                    return SliderRestaurantCard(restaurant: _restaurantsList[index]);
                  },

                ),
              ),
            ),
            SizedBox(height: 20),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("All Restaurants",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width-40,
                        color: Colors.grey,

                      ),
                    );
                  }),
                ),
              ),
            )*/
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
      padding: const EdgeInsets.only(right:5.0),
      child: SizedBox(
        width: 250,
        child: Card(

            elevation: 4.0,
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
                  Stack(
                    children: [Container(
                      height: 120.0,
                      child: Ink.image(

                        image: NetworkImage("https://rb.gy/ib6ugd"),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                            child:  Row(
                              children: [
                                Icon(
                                  Icons.watch,
                                  color: Color(0xFFB6B7B7),
                                ),
                                Text("${restaurant.scheduleList[DateTime.now().weekday-1].started_at.substring(0,5)}-${restaurant.scheduleList[DateTime.now().weekday-1].ended_at.substring(0,5)}", style: TextStyle(color: Color(
                                    0xFF6D6D6D)),),
                              ],
                            ),
                          )),]
                  ),
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
                            SizedBox(width: 5,),
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
