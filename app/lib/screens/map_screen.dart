import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.isNewSelection = true,
    this.lat = 37.422,
    this.lng = -122.084,
  });

  final bool isNewSelection;
  final double lat;
  final double lng;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isNewSelection ? 'Pick a location' : 'Your Location'),
        actions: [
          if (widget.isNewSelection)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lng),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isNewSelection)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ?? LatLng(widget.lat, widget.lng),
                )
              },
        onTap: !widget.isNewSelection
            ? null
            : (position) {
                setState(() {
                  _pickedLocation = position;
                });
              },
      ),
    );
  }
}
