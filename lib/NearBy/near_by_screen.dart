import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {

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

      markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: const LatLng(23.0271070903415, 72.52418723877933),
        infoWindow: const InfoWindow(
          title: 'Star Bazar',
          snippet: 'Shivranjani',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

      markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: const LatLng(23.024415378241, 72.53040256761466),
        infoWindow: const InfoWindow(
          title: 'Shivranjani BRTS',
          snippet: 'Shivranjani',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return markers;
  }

  Widget mapImage(String image, double lat, double long) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.network(image),
      ],
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: mapImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", 23.0271070903415,
                  72.52418723877933),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: mapImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", 23.024164488251714,
                  72.52969479645007),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: mapImage(
                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", 23.024415378241, 72.53040256761466),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _buildContainer();
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
            _buildContainer()
          ],
        ),
      ),
    );
  }
}
