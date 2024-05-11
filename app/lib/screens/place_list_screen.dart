import 'package:app/providers/place_provider.dart';
import 'package:app/screens/place_input_screen.dart';
import 'package:app/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});

  @override
  ConsumerState<PlaceListScreen> createState() {
    return _PlaceListState();
  }
}

class _PlaceListState extends ConsumerState<PlaceListScreen> {
  late Future<void> _places;

  @override
  void initState() {
    super.initState();
    _places = ref.read(placeProvider.notifier).getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const PlaceInputScreen();
                  }));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: _places,
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : places.isEmpty
                      ? const Center(
                          child: Text('No places added yet'),
                        )
                      : ListView.builder(
                          itemCount: places.length,
                          itemBuilder: (ctx, index) {
                            final placePhoto = FileImage(places[index].image);

                            return ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: placePhoto,
                              ),
                              title: Text(
                                places[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              subtitle: Text(
                                places[index].location.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return PlaceDetailScreen(places[index]);
                                }));
                              },
                            );
                          },
                        ),
        ));
  }
}
