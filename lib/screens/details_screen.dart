import 'package:delivery_app/models/menu_item_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:delivery_app/services/network_helper.dart';
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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

class MenuItemContainer extends StatelessWidget {
  MenuItem menuItem;

  MenuItemContainer({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showModalBottomSheet(context: context, builder: (context){
          return Column(
            children: [
              Column(
                children: [
                  Stack(
                      children: [
                        Container(
                        height: 180.0,
                        child: Ink.image(
                          image: NetworkImage("https://rb.gy/ib6ugd"),
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
                          menuItem.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  menuItem.text,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        TextButton(onPressed: (){}, child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add to card"),
                            Text(menuItem.price.toString()),
                          ],
                        ))

                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
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
                  image: NetworkImage("https://rb.gy/ib6ugd"),
                  //NetworkImage("https://rb.gy/ib6ugd"),
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
                    menuItem.name,
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
                          menuItem.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text('${menuItem.price}₸',
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
              restaurant.name,
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
