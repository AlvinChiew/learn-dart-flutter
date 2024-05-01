import 'package:app/data/category_data.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/item_model.dart';
import 'package:flutter/material.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  int _quantity = 0;
  Category _category = categoryData[Categories.carbs]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(hintText: 'Title'),
                onSaved: (input) => _title = input!,
                validator: (input) =>
                    (input == null || input.isEmpty || input.trim().length > 50)
                        ? 'Invalid input'
                        : null,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      initialValue: '0',
                      onSaved: (input) => _quantity = int.parse(input!),
                      validator: (input) => (input == null ||
                              input.isEmpty ||
                              int.tryParse(input) == null ||
                              int.tryParse(input)! < 1)
                          ? 'Invalid input'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _category,
                      items: categoryData.entries
                          .map(
                            (i) => DropdownMenuItem(
                              value: i.value,
                              child: Row(children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: i.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(i.value.title),
                              ]),
                            ),
                          )
                          .toList(),
                      onChanged: (input) => setState(() {
                        _category = input!;
                      }),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => _formKey.currentState!.reset(),
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.of(context).pop(GroceryItem(
                              id: DateTime.now().toString(),
                              name: _title,
                              quantity: _quantity,
                              category: _category));
                        }
                      },
                      child: const Text('Add Item')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
