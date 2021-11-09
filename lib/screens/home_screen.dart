import 'package:delivery_app/screens/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Good morning Morty!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
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
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return RestaurantCard();
                  },

                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
  }) : super(key: key);

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
                    return DetailScreen();
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
                                Text("11:00-20:00", style: TextStyle(color: Color(
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
                          "SDU Pizzeria",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            Text("4.8"),
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
