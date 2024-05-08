import 'dart:io';

import 'package:app/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);

  void modifyPlaces(String title, PlaceLocation location, File image) {
    state = [...state, Place(title, location, image)];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
