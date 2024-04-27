import 'package:app/components/app_drawer.dart';
import 'package:app/data/dummy_data.dart';
import 'package:app/models/meal_model.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/filter_screen.dart';
import 'package:app/screens/meals_screen.dart';
import 'package:flutter/material.dart';

const Map<Filter, bool> _initialFilters = {
  Filter.isGlutenFree: false,
  Filter.isLactoseFree: false,
  Filter.isVegetarian: false,
  Filter.isVegan: false,
};

class ScreenFooter extends StatefulWidget {
  const ScreenFooter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScreenFooterState();
  }
}

class _ScreenFooterState extends State<ScreenFooter> {
  int _selectedTabIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _filters = _initialFilters;

  void _selectTab(tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  void _modifyFavoriteMeals(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  void _selectScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      final newFilters = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen(_filters)));

      setState(() {
        _filters = newFilters ?? _initialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = mealData.where((meal) {
      if (_filters[Filter.isGlutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[Filter.isLactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters[Filter.isVegan]! && !meal.isVegan) {
        return false;
      }
      if (_filters[Filter.isVegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(_modifyFavoriteMeals, filteredMeals);
    String activePageTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = MealsScreen(_favoriteMeals, null, _modifyFavoriteMeals);
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: AppDrawer(_selectScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
