import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({Key? key}) : super(key: key);

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {

  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  static const LatLng location = LatLng(23.024164488251714, 72.52969479645007);

  Set<Marker> getMarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,

        infoWindow: const InfoWindow(
          title: 'Elsner Technology',
          snippet: "Shivranjani",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: location,
                zoom: 20.0,
              ),
              markers: getMarkers(),
              mapType: MapType.satellite,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
