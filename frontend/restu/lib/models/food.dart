import 'package:hive/hive.dart';

part 'food.g.dart';

@HiveType(typeId: 0)
class RestuFood extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final String ingredients;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final int frequency;
  int count = 1;

  RestuFood({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.ingredients,
    required this.description,
    required this.frequency,
  });

  void increaseCount() {
    count = count + 1;
  }

  bool decreaseCount() {
    if (count > 1) {
      count = count - 1;
      return true;
    } else {
      return false;
    }
  }

  RestuFood clone(RestuFood obj) {
    return RestuFood(
        id: obj.id,
        name: obj.name,
        price: obj.price,
        type: obj.type,
        ingredients: obj.description,
        description: obj.description,
        frequency: obj.frequency);
  }

  // RestuFood.clone(RestuFood restuFood): this(restuFood.id, restuFood.name, restuFood.price, restuFood.type, restuFood.ingredients, restuFood.description, restuFood.frequency, restuFood.count);

  static RestuFood fromJson(json) => RestuFood(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        type: json['type'],
        ingredients: json['ingredients'],
        description: json['description'],
        frequency: json['frequency'],
      );
}
