import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/pages/map_page.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput(this.onSelectLocation, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageurl;

  void _showPreview(
    double lat,
    double lng,
  ) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageurl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectLocation(LatLng(
        locData.latitude!,
        locData.longitude!,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MapPage(),
      ),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    widget.onSelectLocation(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: _previewImageurl == null
              ? const Center(
                  child: Text('Localização não informada!'),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    _previewImageurl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _getCurrentUserLocation();
              },
              child: Row(
                children: const [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('Localização Atual'),
                ],
              ),
            ),
            TextButton(
              onPressed: _selectOnMap,
              child: Row(
                children: const [
                  Icon(Icons.map),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('Selecione no Mapa'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
