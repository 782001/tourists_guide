// ignore_for_file: dead_code

import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:tourist_guide/app/home/places/domain/entity/get_places_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    this.lat,
    this.long,
  }) : super(key: key);

  final double? lat;
  final double? long;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
          List<LatLng> positions = cubit.getPlacesEntities?.map((e) {
                double? lat = double.tryParse(e.lat);
                double? lng = double.tryParse(e.lng);
                return LatLng(lat ?? 0, lng ?? 0);
              }).toList() ??
              [];
          Future<Set<Marker>> generateMarkers(List<LatLng> positions) async {
            List<Marker> markers = <Marker>[];
            for (int i = 0; i < positions.length; i++) {
              final entity = cubit.getPlacesEntities![i];
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
                onTap: () => _showAlertDialog(entity),
              );
              Marker myLocationMarker = Marker(
                position: LatLng(widget.lat!, widget.long!),
                infoWindow: InfoWindow(
                    title:
                        AppLocalizations.of(context)!.translate('myLocation')!),
                icon: BitmapDescriptor.fromBytes(
                  blueDotIconBytes,
                  // size: const Size(1, 1)
                ),
                markerId: const MarkerId('myLocation'),
                // onTap: () => _showAlertDialog(),
              );
              markers.add(marker);
              markers.add(myLocationMarker);
            }

            return markers.toSet();
          }

          return ConditionalBuilder(
            condition: cubit.getPlacesEntities != null,
            builder: (context) => FutureBuilder(
              future: generateMarkers(positions),
              initialData: const <Marker>{},
              builder: (context, snapshot) => GoogleMap(
                // circles: circles,
                mapType: MapType.hybrid,
                markers: snapshot.data!,
                initialCameraPosition: myLocationMarker,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
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

          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('No'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   TextButton(
          //     child: const Text('Yes'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}

// --- Button Widget --- //
