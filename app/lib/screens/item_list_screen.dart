import 'package:app/data/item_data.dart';
import 'package:app/models/item_model.dart';
import 'package:app/screens/new_item_screen.dart';
import 'package:flutter/material.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final List<GroceryItem> groceryItems = itemData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
              onPressed: () async {
                final newItem = await Navigator.of(context).push<GroceryItem>(
                    MaterialPageRoute(builder: (ctx) => const NewItemScreen()));

                if (newItem == null) {
                  return;
                }

                setState(() {
                  groceryItems.add(newItem);
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: groceryItems.isEmpty
          ? const Center(child: Text('No items added yet!'))
          : ListView.builder(
              itemCount: groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(groceryItems[index].id),
                onDismissed: (direction) {
                  setState(() {
                    groceryItems.remove(groceryItems[index]);
                  });
                },
                child: ListTile(
                  leading: Container(
                    height: 24,
                    width: 24,
                    color: groceryItems[index].category.color,
                  ),
                  title: Text(groceryItems[index].name),
                  trailing: Text(groceryItems[index].quantity.toString()),
                ),
              ),
            ),
    );
  }
}
