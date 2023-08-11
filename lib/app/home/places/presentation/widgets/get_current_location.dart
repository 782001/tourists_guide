import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({Key? key}) : super(key: key);

  @override
  _GetCurrentLocationState createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission are permanently denied,we cannot request");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 5);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  late String lat;
  late String long;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation().then((value) {
      lat = "${value!.latitude}";
      long = "${value.longitude}";
    });
    _liveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
