import 'package:app/models/place_model.dart';
import 'package:app/screens/map_screen.dart';
import 'package:app/scripts/get_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(this.returnLocation, {super.key});
  final void Function(PlaceLocation location) returnLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class Coordinate {
  const Coordinate(this.lat, this.lng);
  final double lat;
  final double lng;
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _location;
  bool _isFetchingLocation = false;

  void _savePlace([Coordinate? coordinate]) async {
    setState(() {
      _isFetchingLocation = true;
    });

    final location = coordinate == null
        ? await getCurrentLocation()
        : await getLocation(coordinate.lat, coordinate.lng);
    setState(() {
      _location = location;
      _isFetchingLocation = false;
    });
    widget.returnLocation(location!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: _isFetchingLocation
              ? const CircularProgressIndicator()
              : _location == null
                  ? Text(
                      'No place is chosen',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  : Image(image: MemoryImage(_location!.image)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () async {
                  _savePlace();
                },
                icon: const Icon(Icons.location_on),
                label: const Text('Get Current Location')),
            TextButton.icon(
                onPressed: () async {
                  final LatLng? pickedLocation = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) {
                    return const MapScreen();
                  }));

                  if (pickedLocation == null) {
                    return;
                  }
                  _savePlace(Coordinate(
                      pickedLocation.latitude, pickedLocation.longitude));
                },
                icon: const Icon(Icons.map),
                label: const Text('Open Map')),
          ],
        )
      ],
    );
  }
}
