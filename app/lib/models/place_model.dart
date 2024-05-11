import 'dart:io';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(this.latitude, this.longitude, this.address, this.image);

  final double latitude;
  final double longitude;
  final String address;
  final Uint8List image;
}

class Place {
  Place(this.title, this.location, this.image, {String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
}
