import 'dart:convert';

import 'package:app/constant.dart';
import 'package:app/data/category_data.dart';
import 'package:app/models/item_model.dart';
import 'package:app/screens/new_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  void _loadData() async {
    final List<GroceryItem> groceryItems = [];

    try {
      final response = await http.get(Uri.https(url, '$topic.json'));
      // await Future.delayed(const Duration(seconds: 3));

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);

      for (final item in listData.entries) {
        groceryItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: categoryData.entries
                .firstWhere(
                    (catItem) => catItem.value.title == item.value['category'])
                .value,
          ),
        );
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to fetch data';
      });
    }

    setState(() {
      _groceryItems = groceryItems;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    void removeItem(GroceryItem item) async {
      final index = _groceryItems.indexOf(item);
      setState(() {
        _groceryItems.remove(item);
      });

      final response =
          await http.delete(Uri.https(url, '$topic/${item.id}.json'));

      if (response.statusCode >= 400) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete item')));

        setState(() {
          _groceryItems.insert(index, item);
        });
      }
    }

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
                  _groceryItems.add(newItem);
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _groceryItems.isEmpty
                  ? const Center(child: Text('No items added yet!'))
                  : ListView.builder(
                      itemCount: _groceryItems.length,
                      itemBuilder: (ctx, index) => Dismissible(
                        key: ValueKey(_groceryItems[index].id),
                        onDismissed: (direction) {
                          removeItem(_groceryItems[index]);
                        },
                        child: ListTile(
                          leading: Container(
                            height: 24,
                            width: 24,
                            color: _groceryItems[index].category.color,
                          ),
                          title: Text(_groceryItems[index].name),
                          trailing:
                              Text(_groceryItems[index].quantity.toString()),
                        ),
                      ),
                    ),
    );
  }
}
