import 'dart:async';
import 'package:carena/globals/api_keys.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsAndLocation extends StatefulWidget {
  const MapsAndLocation({Key? key}) : super(key: key);

  @override
  State<MapsAndLocation> createState() => _MapsAndLocationState();
}

class _MapsAndLocationState extends State<MapsAndLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourcelocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.43429383, -122.10600055);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentlocation;

  void getCurrentLocation() async {
    Location location = Location();

    await location.getLocation().then(
      (location) {
        currentlocation = location;
        setState(() {});
      },
    );
    final GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newloc) {
        currentlocation = newloc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(newloc.latitude!, newloc.longitude!),
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(
            point.latitude,
            point.longitude,
          ),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    LatLng targetLocation = currentlocation != null
        ? LatLng(currentlocation!.latitude!, currentlocation!.longitude!)
        : LatLng(sourcelocation.latitude, sourcelocation.longitude);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: targetLocation,
        zoom: 12.5,
      ),
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
        ),
      },
      markers: {
        const Marker(
          markerId: MarkerId("source"),
          position: sourcelocation,
        ),
        Marker(
          markerId: const MarkerId("currentlocation"),
          position: targetLocation,
        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destination,
        ),
      },
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
    );
  }
}
