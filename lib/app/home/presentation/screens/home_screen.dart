import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/core/utils/components.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../characters/presentation/screens/heros/heros_screen.dart';
import '../../places/presentation/screens/Map.dart';
import '../controller/home_cubit.dart';
import '../controller/home_states.dart';

import '../../../../core/utils/assets_images_path.dart';
import '../widgets/mydrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<Position?> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error("Location services are disabled");
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error("Location Permission are denied");
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         "Location Permission are permanently denied,we cannot request");
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }
  bool _isPermissionGranted = false;
  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    while (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _getCurrentLocation();
      } else if (permission == LocationPermission.deniedForever) {
        _getCurrentLocation(); // Show a dialog or message to the user to explain why location is needed and how to enable it manually
      } else if (permission == LocationPermission.unableToDetermine) {
        _getCurrentLocation(); // Show a dialog or message to the user to explain why location is needed and how to enable it manually
      }
    }

    return await Geolocator.getCurrentPosition();
  } // Future<Position> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     _showLocationPermissionDialog();
  //     return Future.error("Location services are disabled");
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     _showLocationPermissionDialog();
  //     return Future.error("Location Permission are denied");
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         "Location Permission are permanently denied,we cannot request");
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  // void _showLocationPermissionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Location Permission Needed"),
  //         content: Text(
  //             "This app needs location permission to show your current location on the map."),
  //         actions: [
  //           // TextButton(
  //           //   child: Text("Cancel"),
  //           //   onPressed: () {
  //           //     _showLocationPermissionDialog();
  //           //   },
  //           // ),
  //           TextButton(
  //             child: Text("Open Settings"),
  //             onPressed: () {
  //               Geolocator.openAppSettings()
  //                   .then((value) => NavTo(context, HomeScreen()));
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 5);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  double? lat;

  double? long;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation().then((value) {
      lat = value!.latitude;
      long = value.longitude;
    });
    _liveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      drawerScrimColor: Colors.transparent,
      // drawerScrimColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.blue.shade900,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var cubit = HomeCubit.get(context);
          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AutoSizeText(
                    'TOURIST TOUR GUIDE',
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const AutoSizeText(
                    'E X P E R I E N C E S',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: context.height * .07,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      double defaultLat = 30.054982;
                      double defaultLong = 31.263199;
                      if (lat == null) lat = defaultLat;
                      if (long == null) long = defaultLong;
                      NavTo(
                          context,
                          MapScreen(
                            lat: lat,
                            long: long,
                          ));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: context.height * .22,
                          width: context.width * .85,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Image.asset(
                              homeImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Row(
                            children: [
                              Icon(
                                Icons.maps_home_work_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: context.width * .04,
                              ),
                              AutoSizeText(
                                AppLocalizations.of(context)!
                                    .translate('tour')!,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.height * .07,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      NavTo(context, const HerosScreen());
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: context.height * .22,
                          width: context.width * .85,
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Image.asset(
                              homeImage2,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          right: 20,
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: context.width * .04,
                              ),
                              AutoSizeText(
                                AppLocalizations.of(context)!
                                    .translate('characters')!,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// AIzaSyAd4rEAQqf58fCJGABqW99teDP9BcuyN08
// AIzaSyDeMCv5KIBRscy7eXDwwNTPJgM5zoXGHvw