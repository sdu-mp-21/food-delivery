import 'package:delivery_app/models/menu_item_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  // const DetailScreen({Key? key}) : super(key: key);
  Restaurant restaurant;

  DetailScreen({required this.restaurant});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<MenuItem> _menuItemsList = [];

  @override
  void initState() {
    super.initState();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://fast-cliffs-74827.herokuapp.com/api/restaurants/${widget.restaurant.id}/?format=json");
    networkHelper.getMenu().then((value) {
      setState(() {
        _menuItemsList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DetailsTopContainer(restaurant: widget.restaurant),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _menuItemsList.length,
                  itemBuilder: (context, index) {
                    return MenuItemContainer(menuItem: _menuItemsList[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemContainer extends StatefulWidget {
  MenuItem menuItem;

  MenuItemContainer({
    Key? key,
    required this.menuItem,
  }) : super(key: key);



  @override
  State<MenuItemContainer> createState() => _MenuItemContainerState();
}

class _MenuItemContainerState extends State<MenuItemContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(context: context, builder: (context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Stack(
                      children: [
                        Container(
                          height: 180.0,
                          child: Ink.image(
                            image: NetworkImage(widget.menuItem.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.menuItem.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.menuItem.text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(onPressed: (){}, child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add to card", style: TextStyle(color: Colors.white),),
                                Text(widget.menuItem.price.toString()+"T", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );//MenuItemModalSheet(menuItem: menuItem);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 180,
        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: //NetworkImage(widget.menuItem.imageUrl),
                  NetworkImage("https://rb.gy/ib6ugd"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    widget.menuItem.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.menuItem.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text('${widget.menuItem.price}₸',
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class DetailsTopContainer extends StatelessWidget {
  Restaurant restaurant;

  DetailsTopContainer({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //restaurant image
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  image: NetworkImage("https://rb.gy/ib6ugd"),
                ),
              ),
            ),
          ),
        ),
        //return back and schedule info button
        Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
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
                ),
                MaterialButton(
                  height: 30,
                  minWidth: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                  child: const Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (context){
                      return Column(
                        children: [
                          SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Working hours",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height:250,
                            child: ListView.builder(
                                itemCount: restaurant.scheduleList.length,
                                itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(restaurant.scheduleList[index].start_weekday, style: TextStyle(fontSize: 18)),
                                    Text("${restaurant.scheduleList[index].started_at.substring(0,5)}-${restaurant.scheduleList[index].ended_at.substring(0,5)}",)
                                    ],
                                  ),
                                );
                            }),
                          ),
                          SizedBox(height:20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(onPressed: () => Navigator.of(context).pop(), child: const Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                              child: Text("Close", style: TextStyle(color: Colors.white)),
                            ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  },
                ),

              ],
            )),
        //restaurant details
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              restaurant.name,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 20, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "${restaurant.address.text_address}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            )
          ]),
        ),
        //restaurant rating
        Positioned(
            right: 20.0,
            bottom: 30.0,
            child: Row(
              children: [
                Text(
                  restaurant.rating.toString(),
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
