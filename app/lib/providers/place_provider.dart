import 'dart:io';
import 'dart:typed_data';

import 'package:app/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as system_path;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);

  Future<sql.Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    const dbName = 'app.db';
    return await sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) => db.execute('''CREATE TABLE PLACES(
              id TEXT PRIMARY KEY
              , title TEXT
              , place_image TEXT
              , map_image REAL
              , lat REAL
              , lng REAL
              , address TEXT);'''),
      version: 1,
    );
  }

  Future<void> getPlaces() async {
    final db = await _getDatabase();

    final data = await db.query('places');
    state = data
        .map((row) => Place(
              row['title'] as String,
              PlaceLocation(
                row['lat'] as double,
                row['lng'] as double,
                row['address'] as String,
                row['map_image'] as Uint8List,
              ),
              File(row['place_image'] as String),
              id: row['id'] as String,
            ))
        .toList();
  }

  void addPlace(String title, PlaceLocation location, File image) async {
    final appDir = await system_path.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final db = await _getDatabase();
    final p = Place(title, location, copiedImage);
    db.insert('places', {
      'id': p.id,
      'title': p.title,
      'place_image': p.image.path,
      'map_image': p.location.image,
      'lat': p.location.latitude,
      'lng': p.location.longitude,
      'address': p.location.address,
    });

    state = [...state, p];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
