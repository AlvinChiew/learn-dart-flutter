import 'dart:convert';

import 'package:app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

String getMapUrl(
  String? lat,
  String? lng,
  String? apiKey,
) {
  return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
}

final String? _api = dotenv.env['API_KEY'];

Future<PlaceLocation?> getCurrentLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  final locationData = await location.getLocation();
  // return locationData;

  final lat = locationData.latitude;
  final lng = locationData.longitude;

  if (lat == null || lng == null) {
    return null;
  }

  return getLocation(lat, lng);
}

Future<PlaceLocation> getLocation(double lat, double lng) async {
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$_api');

  final response = await http.get(url);
  final resJson = json.decode(response.body);
  final address = resJson['results'][0]['formatted_address'];

  // final image = Image.network(
  //   getMapUrl(lat.toString(), lng.toString(), dotenv.env['API_KEY']),
  //   fit: BoxFit.cover,
  //   width: double.infinity,
  //   height: double.infinity,
  // );

  final imageByte = await http
      .get(Uri.parse(
        getMapUrl(lat.toString(), lng.toString(), dotenv.env['API_KEY']),
      ))
      .then((response) => response.bodyBytes);

  return PlaceLocation(lat, lng, address, MemoryImage(imageByte));
}
