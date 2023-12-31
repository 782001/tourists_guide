// ignore_for_file: dead_code

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tourist_guide/app/home/places/domain/entity/get_places_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_guide/core/utils/components.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import '../../../../../config/locale/app_localizations.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../localization/presentation/cubit/locale_cubit.dart';
import '../controller/places_cubit.dart';
import '../controller/places_states.dart';
import 'dialog_content.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.placesData,
    this.lat,
    this.long,
  }) : super(key: key);

  final double? lat;
  final double? long;
  final GetPlacesEntities placesData;
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late BitmapDescriptor customIcon;
  GoogleMapController? _mapController;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final myLocIcon =
        MyLocIconWidget(0); // Your custom animated location icon widget
    myLocIcon.paint(canvas, Size(100.0, 100.0)); // Adjust the size as needed

    final img = await recorder
        .endRecording()
        .toImage(100, 100); // Adjust the size as needed
    final ByteData? byteData =
        await img.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    setState(() {
      customIcon = BitmapDescriptor.fromBytes(uint8List);
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() {
              isAlertSet = true;
            });
          }
        },
      );
  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition myLocationMarker = CameraPosition(
      target: LatLng(widget.lat!, widget.long!),
      zoom: 30,
    );

    // final CameraPosition kLake = CameraPosition(
    //   bearing: 192.8334901395799,
    //   target: LatLng(widget.lat, widget.long),
    //   tilt: 59.440717697143555,
    //   zoom: 19.151926040649414,
    // );

    // Set<Circle> circles = {
    //   Circle(
    //     circleId: const CircleId("currentCircle"),
    //     center: LatLng(widget.lat, widget.long),
    //     radius: 4000,
    //     fillColor: Colors.blue,
    //     strokeColor: Colors.blue.shade100.withOpacity(0.1),
    //   )
    // };

    return Scaffold(
      body: BlocConsumer<PlacesCubit, PlacesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PlacesCubit.get(context);

          // List<LatLng> positions = [
          //   // LatLng(widget.lat, widget.long),

          //   // LatLng(cubit.getPlacesEntities!.iterator.current.lat as double,
          //   //     cubit.getPlacesEntities!.iterator.current.lng as double),
          //   const LatLng(30.045373, 31.262694),
          //   const LatLng(30.045716, 31.262496),
          //   const LatLng(30.046382, 31.245046),
          //   const LatLng(30.050407, 31.261980),// ];
          // List<LatLng> positions = cubit.getPlacesEntities!.map((e) {
          //   double lat = double.parse(e.lat);
          //   double lng = double.parse(e.lng);
          //   return LatLng(lat, lng);
          // }).toList();

          LatLng PlaceLocation;
          double? lat = double.tryParse(widget.placesData.lat);
          double? lng = double.tryParse(widget.placesData.lng);
          PlaceLocation = LatLng(lat ?? 0, lng ?? 0);
          final CameraPosition PlaceLocationMarker = CameraPosition(
            target: PlaceLocation,
            zoom: 15,
          );
//           Future<Set<Marker>> generateMarkers(LatLng positions) async {
//             List<Marker> markers = <Marker>[];
//             {
//               final entity = widget.placesData;
//               final location = positions;
//               //here i calculate the distance between my location and my markers location
//               double distance = Geolocator.distanceBetween(widget.lat!,
//                   widget.long!, location.latitude, location.longitude);
//               print(
//                   "$distance llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
//               // BitmapDescriptor icon = BitmapDescriptor.defaultMarkerWithHue(
//               //     BitmapDescriptor.hueViolet);
//               // BitmapDescriptor icon = distance <= 15
//               //     ?  BitmapDescriptor.fromBytes(
//               //    mahatatIconBytes,
//               //     // size: const Size(1, 1)
//               //   )
//               //     :  BitmapDescriptor.fromBytes(
//               //    mahatatIconBytes,
//               //     // size: const Size(1, 1)
//               //   );
//               // mahatat.png

// //#########################################
// // here i change my location icon
//               final ByteData blueDotIconData =
//                   // await rootBundle.load('assets/images/location_Icon.png');
//                   await rootBundle.load('assets/images/current.png');
//               // final Uint8List blueDotIconBytes =
//               //     Uint8List.view(blueDotIconData.buffer);
//               final ui.Codec codec = await ui.instantiateImageCodec(
//                 blueDotIconData.buffer.asUint8List(),
//                 targetWidth: 250,
//                 targetHeight: 250,
//               );
//               final ui.FrameInfo frameInfo = await codec.getNextFrame();
//               // click on blueDotIconBytes to see where and how it work
//               final Uint8List blueDotIconBytes = await frameInfo.image
//                   .toByteData(format: ui.ImageByteFormat.png)
//                   .then((data) => data!.buffer.asUint8List());

//               /// ########################################
// // here i change mahatat location icon
//               final ByteData mahatatIconData =
//                   // await rootBundle.load('assets/images/location_Icon.png');
//                   await rootBundle.load('assets/images/mahatat.png');
//               // final Uint8List blueDotIconBytes =
//               //     Uint8List.view(blueDotIconData.buffer);
//               final ui.Codec mahatatcodec = await ui.instantiateImageCodec(
//                 mahatatIconData.buffer.asUint8List(),
//                 targetWidth: 250,
//                 targetHeight: 250,
//               );
//               final ui.FrameInfo mahatatframeInfo =
//                   await mahatatcodec.getNextFrame();
//               // click on blueDotIconBytes to see where and how it work
//               final Uint8List mahatatIconBytes = await mahatatframeInfo.image
//                   .toByteData(format: ui.ImageByteFormat.png)
//                   .then((data) => data!.buffer.asUint8List());
//               final ByteData NerestmahatatIconData =
//                   // await rootBundle.load('assets/images/location_Icon.png');
//                   await rootBundle.load('assets/images/nerest.png');
//               // final Uint8List blueDotIconBytes =
//               //     Uint8List.view(blueDotIconData.buffer);
//               final ui.Codec Nerestmahatatcodec =
//                   await ui.instantiateImageCodec(
//                 NerestmahatatIconData.buffer.asUint8List(),
//                 targetWidth: 250,
//                 targetHeight: 250,
//               );
//               final ui.FrameInfo NerestmahatatframeInfo =
//                   await Nerestmahatatcodec.getNextFrame();
//               // click on blueDotIconBytes to see where and how it work
//               final Uint8List NerestmahatatIconBytes =
//                   await NerestmahatatframeInfo.image
//                       .toByteData(format: ui.ImageByteFormat.png)
//                       .then((data) => data!.buffer.asUint8List());
//               BitmapDescriptor icon = distance <= 100
//                   ? BitmapDescriptor.fromBytes(
//                       NerestmahatatIconBytes,
//                       // size: const Size(1, 1)
//                     )
//                   : BitmapDescriptor.fromBytes(
//                       mahatatIconBytes,
//                       // size: const Size(1, 1)
//                     );

//               /// ######################################## /// ########################################
//               Marker marker = Marker(
//                 infoWindow: InfoWindow(
//                     title:
//                         BlocProvider.of<LocaleCubit>(context).currentLangCode ==
//                                 AppStrings.englishCode
//                             ? entity.titleEN
//                             : entity.titleAR),
//                 markerId: MarkerId(location.toString()),
//                 position: LatLng(location.latitude, location.longitude),
//                 icon: icon,
//                 onTap: () {},
//                 // onTap: () => _showAlertDialog(entity),
//               );
//               Marker myLocationMarker = Marker(
//                 position: LatLng(widget.lat!, widget.long!),
//                 infoWindow: InfoWindow(
//                     title:
//                         AppLocalizations.of(context)!.translate('myLocation')!),
//                 icon: BitmapDescriptor.fromBytes(
//                   blueDotIconBytes,
//                   // size: const Size(1, 1)
//                 ),
//                 markerId: const MarkerId('myLocation'),
//                 // onTap: () => _showAlertDialog(),
//               );
//               markers.add(marker);
//               markers.add(myLocationMarker);
//             }

//             return markers.toSet();
//           }

          //!
          List<LatLng> positions = cubit.getPlacesEntities.map((e) {
                double? lat = double.tryParse(e.lat);
                double? lng = double.tryParse(e.lng);
                return LatLng(lat ?? 0, lng ?? 0);
              }).toList() ??
              [];
          //!
          //!
          LatLng? nearestPlace;
          double minDistance = 2;
          Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
            List<Marker> markers = <Marker>[];

            // nearestPlace = findNearestPlace(positions);

            for (int i = 0; i < positions.length; i++) {
              final entity = cubit.getPlacesEntities[i];
              final location = positions[i];
              //here i calculate the distance between my location and my markers location
              double distance = Geolocator.distanceBetween(widget.lat!,
                  widget.long!, location.latitude, location.longitude);
              print(
                  "$distance llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
              // BitmapDescriptor icon = BitmapDescriptor.defaultMarkerWithHue(
              //     BitmapDescriptor.hueViolet);
              // BitmapDescriptor icon = distance <= 15
              //     ?  BitmapDescriptor.fromBytes(
              //    mahatatIconBytes,
              //     // size: const Size(1, 1)
              //   )
              //     :  BitmapDescriptor.fromBytes(
              //    mahatatIconBytes,
              //     // size: const Size(1, 1)
              //   );
              // mahatat.png

//#########################################
// here i change my location icon
              final ByteData blueDotIconData =
                  // await rootBundle.load('assets/images/location_Icon.png');
                  await rootBundle.load('assets/images/current.png');
              // final Uint8List blueDotIconBytes =
              //     Uint8List.view(blueDotIconData.buffer);
              final ui.Codec codec = await ui.instantiateImageCodec(
                blueDotIconData.buffer.asUint8List(),
                targetWidth: 250,
                targetHeight: 250,
              );
              final ui.FrameInfo frameInfo = await codec.getNextFrame();
              // click on blueDotIconBytes to see where and how it work
              final Uint8List blueDotIconBytes = await frameInfo.image
                  .toByteData(format: ui.ImageByteFormat.png)
                  .then((data) => data!.buffer.asUint8List());

              /// ########################################
// here i change mahatat location icon
              final ByteData mahatatIconData =
                  // await rootBundle.load('assets/images/location_Icon.png');
                  await rootBundle.load('assets/images/mahatat.png');
              // final Uint8List blueDotIconBytes =
              //     Uint8List.view(blueDotIconData.buffer);
              final ui.Codec mahatatcodec = await ui.instantiateImageCodec(
                mahatatIconData.buffer.asUint8List(),
                targetWidth: 250,
                targetHeight: 250,
              );
              final ui.FrameInfo mahatatframeInfo =
                  await mahatatcodec.getNextFrame();
              // click on blueDotIconBytes to see where and how it work
              final Uint8List mahatatIconBytes = await mahatatframeInfo.image
                  .toByteData(format: ui.ImageByteFormat.png)
                  .then((data) => data!.buffer.asUint8List());
              final ByteData NerestmahatatIconData =
                  // await rootBundle.load('assets/images/location_Icon.png');
                  await rootBundle.load('assets/images/nerest.png');
              // final Uint8List blueDotIconBytes =
              //     Uint8List.view(blueDotIconData.buffer);
              final ui.Codec Nerestmahatatcodec =
                  await ui.instantiateImageCodec(
                NerestmahatatIconData.buffer.asUint8List(),
                targetWidth: 250,
                targetHeight: 250,
              );
              final ui.FrameInfo NerestmahatatframeInfo =
                  await Nerestmahatatcodec.getNextFrame();
              // click on blueDotIconBytes to see where and how it work
              final Uint8List NerestmahatatIconBytes =
                  await NerestmahatatframeInfo.image
                      .toByteData(format: ui.ImageByteFormat.png)
                      .then((data) => data!.buffer.asUint8List());
              BitmapDescriptor icon = distance <= 100
                  ? BitmapDescriptor.fromBytes(
                      NerestmahatatIconBytes,
                      // size: const Size(1, 1)
                    )
                  : BitmapDescriptor.fromBytes(
                      mahatatIconBytes,
                      // size: const Size(1, 1)
                    );

              /// ######################################## /// ########################################
              Marker marker = Marker(
                infoWindow: InfoWindow(
                    title:
                        BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                                AppStrings.englishCode
                            ? entity.titleEN
                            : entity.titleAR),
                markerId: MarkerId(location.toString()),
                position: LatLng(location.latitude, location.longitude),
                icon: icon,
                onTap: () {},
                // onTap: () => _showAlertDialog(entity),
              );
              Marker myLocationMarker = Marker(
                position: LatLng(widget.lat!, widget.long!),
                infoWindow: InfoWindow(
                    title:
                        AppLocalizations.of(context)!.translate('myLocation')!),
                icon:
                    //  BitmapDescriptor.fromBytes(
                    customIcon,
                // icon: BitmapDescriptor.fromBytes(
                //   blueDotIconBytes,
                //   // size: const Size(1, 1)
                // ),
                markerId: const MarkerId('myLocation'),
                // onTap: () => _showAlertDialog(),
              );
              markers.add(marker);
              markers.add(myLocationMarker);
            }

            return markers.toSet();
          }

          Marker _tappedLocationMarker = Marker(
            markerId: MarkerId('tappedLocation'),
            position: LatLng(0, 0),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );
          List<LatLng> findNearestPlaces(
              List<LatLng> positions, LatLng tappedItemLocation) {
            // LatLng myLocation = LatLng(widget.lat!, widget.long!);
            List<LatLng> nearestPlaces = [];
            double maxDistance = 3000; // 2 kilometers

            for (LatLng place in positions) {
              double distance = Geolocator.distanceBetween(
                tappedItemLocation.latitude,
                tappedItemLocation.longitude,
                place.latitude,
                place.longitude,
              );

              if (distance <= maxDistance && distance > 0.0) {
                nearestPlaces.add(place);
              }
            }

            return nearestPlaces;
          }

          void _moveCamera(LatLng position) async {
            if (_mapController != null) {
              _mapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: position,
                    zoom: 16.0, // Adjust the zoom level as needed
                  ),
                ),
              );
            }
          }

          Widget _buildSuggestions(
              LatLng tappedItemLocation, Function(LatLng) onLocationUpdate) {
            List<LatLng> nearestPlaces =
                findNearestPlaces(positions, tappedItemLocation);
            print("Tapped Item Location: $tappedItemLocation");
            print("All Positions: $positions");
            print("Nearest Places: $nearestPlaces");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: nearestPlaces.asMap().entries.map((entry) {
                  int index = entry.key;
                  LatLng position = entry.value;
                  // print(position);
                  double distance = Geolocator.distanceBetween(
                    tappedItemLocation.latitude,
                    tappedItemLocation.longitude,
                    position.latitude,
                    position.longitude,
                  );
                  print("distance:$distance");
                  int originalIndex = positions.indexOf(position);
                  GetPlacesEntities entity =
                      cubit.getPlacesEntities[originalIndex];

                  return GestureDetector(
                    onTap: () {
                      // Call the callback to update the tapped location
                      // onLocationUpdate(position);
                      setState(() {
                        _tappedLocationMarker = _tappedLocationMarker.copyWith(
                          positionParam:
                              LatLng(position.latitude, position.longitude),
                        );
                      });
                      // Update the camera position
                      _moveCamera(position);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Container(
                        height: context.height * 0.12,
                        width: context.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 4,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Container(
                                height: context.height * 0.15,
                                width: context.width * 0.6,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: flutter.Image(
                                  image: NetworkImage(
                                    entity.images.first.url,
                                  ),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.0),
                                Center(
                                  child: AutoSizeText(
                                    BlocProvider.of<LocaleCubit>(context)
                                                .currentLangCode ==
                                            AppStrings.englishCode
                                        ? entity.titleEN
                                        : entity.titleAR,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black, blurRadius: 10)
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Center(
                                    child: AutoSizeText(
                                  '${AppLocalizations.of(context)!.translate('Distance')!} ${distance.toDouble().toStringAsFixed(2)} ${AppLocalizations.of(context)!.translate('meter')!} ',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black, blurRadius: 10)
                                      ]),
                                )),
                                // Add any other information you want to display
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }

//!
          return ConditionalBuilder(
            condition: cubit.getPlacesEntities != null,
            builder: (context) => FutureBuilder(
              future: generateMarkers(positions),
              initialData: const <Marker>{},
              builder: (context, snapshot) => Stack(
                children: [
                  GoogleMap(
                    // circles: circles,
                    mapType: MapType.hybrid,
                    markers: snapshot.data!,
                    initialCameraPosition: PlaceLocationMarker,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _mapController = controller; // Assign the controller
                    },
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: _buildSuggestions(
                      PlaceLocation,
                      (newLocation) {
                        print("last:$PlaceLocation");
                        setState(() {
                          PlaceLocation = newLocation;
                          print("new:$PlaceLocation");
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Future<void> _showAlertDialog(GetPlacesEntities entity) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          // <-- SEE HERE
          // icon: Align(alignment: AlignmentDirectional.topStart,
          //   child: IconButton(
          //     icon: const Icon(Icons.close),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              // height: context.height * .5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListBody(
                    children: <Widget>[
                      DialogContent(entity: entity)
                      // SizedBox(
                      //   height: context.height * 0.03,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showDialogBox() => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('No Connection'),
          content: Text('Please check your internet connectivity'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: Text('OK'),
            )
          ],
        ),
      );
}

// --- Button Widget --- //
class MyLocIconWidget extends CustomPainter {
  final double animationValue;

  MyLocIconWidget(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 3; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 25, 100, 220)
          .withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;

  MyCustomPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 3; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = Color(0xff19DC7C).withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
