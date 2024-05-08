import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(this.latitude, this.longitude, this.address, this.image);

  final double latitude;
  final double longitude;
  final String address;
  final MemoryImage image;
}

class Place {
  Place(this.title, this.location, this.image) : id = uuid.v4();

  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
}
