import 'package:delivery_app/models/data_model.dart';
import 'package:delivery_app/models/menu_item_model.dart';
import 'package:delivery_app/models/restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.url});

  final String url; //https://fast-cliffs-74827.herokuapp.com/api/restaurants

  Future<List<Restaurant>> getRestaurant() async{
    var response = await http.get(Uri.parse(url));

    if(response.statusCode ==200){
      List<Restaurant> restaurantList=[];
      //Iterable<dynamic> l = json.decode(response.body);
      //List<Restaurant> restaurantList = List<Restaurant>.from(l.map((model)=> Restaurant.fromJson(model))).toList();
      var restaurantsJson = json.decode(response.body);
       for(var restaurantJson in restaurantsJson){
         restaurantList.add(Restaurant.fromJson(restaurantJson));
       }
      //List<Restaurant> restaurantList = List.generate(restaurantsJson.length, (i) => Restaurant.fromJson(restaurantsJson[i]));
      return restaurantList;
    }else{
      throw Exception('Failed to load restaurant');
    }
  }

  Future<List<MenuItem>> getMenu() async{
    var response = await http.get(Uri.parse(url));
    List<MenuItem> menuItemsList = [];
    if(response.statusCode ==200){
      var menusJson = json.decode(response.body);
      var list = menusJson['food_set'] as List;
      menuItemsList = list.map((i) => MenuItem.fromJson(i)).toList();
      }
    return menuItemsList;
  }
    Future<DataItem> getData() async{
    var response = await http.get(Uri.parse(url));
    var menusJson = {} as DataItem;
    if(response.statusCode ==200){
      menusJson = json.decode(response.body); 
      }
    return menusJson;
  }

  //  //url = "https://fast-cliffs-74827.herokuapp.com/api/restaurants/?format=json";

  // Future<dynamic> getData() async {
  //   http.Response response;

  //   response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     return jsonDecode(data);
  //   } else {
  //     print(response.statusCode);
  //     return;
  //   }


  // }

}