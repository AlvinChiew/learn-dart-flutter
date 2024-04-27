import 'package:flutter/material.dart';

enum Filter {
  isGlutenFree,
  isLactoseFree,
  isVegetarian,
  isVegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen(this.filters, {super.key});
  final Map<Filter, bool> filters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.filters[Filter.isGlutenFree]!;
    _isLactoseFree = widget.filters[Filter.isLactoseFree]!;
    _isVegetarian = widget.filters[Filter.isVegetarian]!;
    _isVegan = widget.filters[Filter.isVegan]!;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filterItems = [
      {
        'title': 'Gluten-Free',
        'description': 'Only include gluten-free meals.',
        'state': _isGlutenFree,
        'setState': (input) {
          setState(() {
            _isGlutenFree = input;
          });
        }
      },
      {
        'title': 'Lactose-Free',
        'description': 'Only include lactose-free meals.',
        'state': _isLactoseFree,
        'setState': (input) {
          setState(() {
            _isLactoseFree = input;
          });
        }
      },
      {
        'title': 'Vegetarian',
        'description': 'Only include meals for vegetarians.',
        'state': _isVegetarian,
        'setState': (input) {
          setState(() {
            _isVegetarian = input;
          });
        }
      },
      {
        'title': 'Vegan',
        'description': 'Only include meals for vegans.',
        'state': _isVegan,
        'setState': (input) {
          setState(() {
            _isVegan = input;
          });
        }
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.isGlutenFree: _isGlutenFree,
            Filter.isLactoseFree: _isLactoseFree,
            Filter.isVegetarian: _isVegetarian,
            Filter.isVegan: _isVegan,
          });
          return false;
        },
        child: Column(
            children: filterItems.map((i) {
          return SwitchListTile(
            title: Text(i['title'],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            subtitle: Text(i['description'],
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            value: i['state'],
            onChanged: i['setState'],
          );
        }).toList()),
      ),
    );
  }
}
