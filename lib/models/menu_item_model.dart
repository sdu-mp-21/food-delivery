class MenuItem{

  int id;
  String name;
  int price;
  String text;
  String imageUrl;
  MenuItem({required this.id,required this.name, required this.price, required this.text, required this.imageUrl});

  factory MenuItem.fromJson(Map<String, dynamic> parsedJson){
    return MenuItem(
        id:parsedJson['id'],
        name:parsedJson['title'],
        price: parsedJson['price'],
        text: parsedJson['text'],
        imageUrl: parsedJson['image']
    );
  }
}