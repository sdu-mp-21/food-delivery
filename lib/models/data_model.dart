
class DataItem{

  int id;
  String first_name;
  String last_name;
  String username;
  List<String>? address_set;
  
  DataItem({required this.id,required this.username, required this.first_name, required this.last_name, address_set});

  factory DataItem.fromJson(Map<String, dynamic> parsedJson){
    return DataItem(
        id:parsedJson['id'],
        first_name:parsedJson['first_name'],
        last_name:parsedJson['last_name'],
        username:parsedJson['username'],
        address_set:parsedJson['address_set'],
    );
  }
}