import 'package:app/data/category_data.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/item_model.dart';

final itemData = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categoryData[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categoryData[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categoryData[Categories.meat]!),
];
