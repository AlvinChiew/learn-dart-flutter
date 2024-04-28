import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(this.onSelectScreen, {super.key});
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.55)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking up!',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
          DrawerTile(Icons.restaurant, 'Meals', onSelectScreen, 'meals'),
          DrawerTile(Icons.settings, 'Filters', onSelectScreen, 'filters')
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(this.icon, this.title, this.selectScreen, this.identifier,
      {super.key});
  final IconData icon;
  final String title;
  final Function(String identifier) selectScreen;
  final String identifier;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          size: 26, color: Theme.of(context).colorScheme.onBackground),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      onTap: () {
        selectScreen(identifier);
      },
    );
  }
}
