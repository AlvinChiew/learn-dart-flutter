import 'package:app/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);

    List<Map<String, dynamic>> filterItems = [
      {
        'title': 'Gluten-Free',
        'description': 'Only include gluten-free meals.',
        'filter': Filter.isGlutenFree,
      },
      {
        'title': 'Lactose-Free',
        'description': 'Only include lactose-free meals.',
        'filter': Filter.isLactoseFree,
      },
      {
        'title': 'Vegetarian',
        'description': 'Only include meals for vegetarians.',
        'filter': Filter.isVegetarian,
      },
      {
        'title': 'Vegan',
        'description': 'Only include meals for vegans.',
        'filter': Filter.isVegan,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
          children: filterItems.map((i) {
        return SwitchListTile(
          title: Text(i['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          subtitle: Text(i['description'],
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
          value: filters[i['filter']]!,
          onChanged: (input) {
            ref.read(filterProvider.notifier).modifyFilter(i['filter'], input);
          },
        );
      }).toList()),
    );
  }
}
