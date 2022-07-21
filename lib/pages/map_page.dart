import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapPage extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapPage(
      {this.initialLocation = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
      ),
      this.isReadOnly = false,
      Key? key})
      : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _pickedPosition;

  void _selecPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: [
          IconButton(
            onPressed: _pickedPosition == null
                ? null
                : () {
                    Navigator.of(context).pop(_pickedPosition);
                  },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 15,
        ),
        onTap: widget.isReadOnly ? null : _selecPosition,
        markers: {
          Marker(
            markerId: const MarkerId('p1'),
            position: _pickedPosition == null
                ? LatLng(
                    widget.initialLocation.latitude,
                    widget.initialLocation.longitude,
                  )
                : _pickedPosition!,
          ),
        },
      ),
    );
  }
}
