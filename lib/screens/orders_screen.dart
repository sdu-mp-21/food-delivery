import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/services/network_helper.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  NetworkHelper networkHelper = NetworkHelper(
      url:
      "http://thawing-taiga-45359.herokuapp.com/api/orders/?format=json");
  List<Order> _ordersList = [];

  @override
  void initState() {
    super.initState();
    networkHelper.getOrders().then((value) {
      setState(() {
        _ordersList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _ordersList.length,
                itemBuilder: (context, ind){
              return Column(
                children: [
                  Text(_ordersList[ind].restaurant.toString()),
                  Text(_ordersList[ind].address.toString()),
                  Text(_ordersList[ind].price.toString()),
                  Text(_ordersList[ind].delivery_price.toString())

                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
