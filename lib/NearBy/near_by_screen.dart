import 'package:barber_booking_management/NearBy/current_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Firebase/firebase_collection.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {

  late GoogleMapController mapController;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    FirebaseCollection().shopCollection.get().then((value) {
      for(int i=0;i<value.docs.length;i++){
        markers.add(Marker(markerId: MarkerId(value.docs[i].id),
            infoWindow:  InfoWindow(title: value.docs[i]['shopName']),
            position: LatLng(double.parse(value.docs[i]["latitude"]),double.parse(value.docs[i]["longitude"])),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            )),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  FutureBuilder<LocationData?>(
            future: CurrentLocation.instance.currentLocation(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator());
              }else{
                markers.add(Marker(
                  markerId: const MarkerId("1"),
                  onTap: (){},
                  infoWindow: const InfoWindow(title: "You are here"),
                  position: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ));
                return GoogleMap(
                  zoomGesturesEnabled: true,
                  myLocationEnabled : true,
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  tiltGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  indoorViewEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                    zoom: 11.0,
                  ),
                  markers: markers,
                  onTap: (latLng){},
                );
              }
            }
        ),
      ),
    );
  }
}
