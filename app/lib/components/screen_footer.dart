import 'package:app/components/app_drawer.dart';
import 'package:app/providers/filter_provider.dart';
import 'package:app/screens/category_screen.dart';
import 'package:app/screens/filter_screen.dart';
import 'package:app/screens/meals_screen.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenFooter extends ConsumerStatefulWidget {
  const ScreenFooter({super.key});

  @override
  ConsumerState<ScreenFooter> createState() {
    return _ScreenFooterState();
  }
}

class _ScreenFooterState extends ConsumerState<ScreenFooter> {
  int _selectedTabIndex = 0;

  void _selectTab(tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  void _selectScreen(String screen) {
    Navigator.of(context).pop();
    if (screen == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealProvider);

    Widget activePage = CategoryScreen(filteredMeals);
    String activePageTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      final favoriteMeals = ref.watch(favoriteProvider);
      activePageTitle = 'Favorites';
      activePage = MealsScreen(favoriteMeals, null);
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
