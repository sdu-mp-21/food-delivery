
import 'package:delivery_app/models/menu_item_model.dart';

class Restaurant{

  int id;
  String name;
  double rating;
  String imageUrl;
 // List<MenuItem> menuItems;

  Restaurant(this.id, this.name, this.rating, this.imageUrl);

  Restaurant.fromJson(Map json)

      : id = json['id'],
        name = json['title'],
        rating = json['rating'],
        imageUrl = json['image'];
        //menuItems = json['food_set'];

//   factory Restaurant.fromJson(Map<String, dynamic> parsedJson){
//     //var list = parsedJson['food_set'] as List;
//    // List<MenuItem> menuList = list.map((i) => MenuItem.fromJson(i)).toList();
//     return Restaurant(
//         id: parsedJson['id'],
//         name: parsedJson['title'],
//         rating: parsedJson['rating'],
//         imageUrl: parsedJson['image']
// //        menuItems: menuList
//     );
//  }
}