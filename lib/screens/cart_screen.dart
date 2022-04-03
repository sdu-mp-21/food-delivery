import 'package:delivery_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List encondeToJson(List<CartItem> list) {
    List jsonList = [];
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  Future<void> placeOrder(
      List<CartItem> items,
      int foodPrice,
      int deliveryPrice,
      int personsCount,
      int restaurant,
      int user,
      int address) async{
    List<CartItem> list=[];
    items.forEach((food) {

      list.add(food);
    });
    var finalJson = {"orderfood_set": encondeToJson(list)};
    print(finalJson);

    var response =  await http.post(
        Uri.parse("http://thawing-taiga-45359.herokuapp.com/api/orders/"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(<String, dynamic>{
          "foods_price": foodPrice,
          "delivery_price": deliveryPrice,
          "persons_count": personsCount,
          "restaurant": restaurant,
          "user": user,
          "address": address,
          "orderfood_set": encondeToJson(list),
        })
    );
    print(json.decode(response.body));
    if(response.statusCode==201){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Order placed successfully")
          ));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Error accured")
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
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
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Shopping cart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                  ),
                ),
              ),

               ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                 itemCount: cart.items.length,
                  itemBuilder: (context, i){
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                      ),
                      key: ValueKey<String>(cart.items.values.toList()[i].id),
                      onDismissed: (DismissDirection direction) {
                        cart.removeItem(cart.items.values.toList()[i].id);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width-40,
                        height: 100,
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage("https://bit.ly/3FfFeoB"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100.0,
                                  child: Text(
                                    cart.items.values.toList()[i].name,
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () { cart.decreaseQuantity(cart.items.values.toList()[i].id); },
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        cart.items.values.toList()[i].quantity.toString(),
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cart.increaseQuantity(cart.items.values.toList()[i].id);
                                        },
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[300],
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      "${cart.items.values.toList()[i].price * cart.items.values.toList()[i].quantity}T",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );


                  },
                ),
              SizedBox(height:20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),

                  ),

                  Text(
                    "${cart.totalAmount}T",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),

                  )
                ],
              ),

              SizedBox(height:15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Delivary charge",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),

                  ),

                  Text(
                    "500T",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),

                  )
                ],
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),

                  ),

                  Text(
                    "${cart.totalAmount+500}T",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),

                  )
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: MaterialButton(
                    onPressed: (){
                      placeOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                          500,
                          2,
                          2,
                          4,
                          1);
                      cart.clear();
                    },
                    color: Colors.deepOrange,
                    height: 50.0,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "PROCEED TO CHECKOUT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ),

              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}