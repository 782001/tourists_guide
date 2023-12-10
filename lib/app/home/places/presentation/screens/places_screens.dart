import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/app/home/places/domain/entity/get_places_entities.dart';
import 'package:tourist_guide/app/home/places/presentation/screens/places_detailes.dart';
import 'package:tourist_guide/app/home/places/presentation/screens/qr_places_screen.dart';
import 'package:tourist_guide/core/utils/app_strings.dart';
import 'package:tourist_guide/core/utils/assets_images_path.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/locale/app_localizations.dart';

import '../../../../../core/utils/components.dart';
import '../../../../localization/presentation/cubit/locale_cubit.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../controller/places_cubit.dart';
import '../controller/places_states.dart';
import 'package:flutter/widgets.dart' as flutter;

class PlacesScreens extends StatefulWidget {
  const PlacesScreens({
    Key? key,
    required this.lat,
    required this.long,
  }) : super(key: key);
  final double? lat;
  final double? long;

  @override
  State<PlacesScreens> createState() => _PlacesScreensState();
}

class _PlacesScreensState extends State<PlacesScreens> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });
  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: AutoSizeText(
          AppLocalizations.of(context)!.translate('tour')!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PlacesCubit, PlacesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PlacesCubit.get(context);
            return ConditionalBuilder(
              condition: PlacesCubit.get(context).getPlacesEntities.isNotEmpty,
              builder: (context) => Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  width: context.width * .9,
                  height: context.height * .85,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      // crossAxisCount: 3,
                      // mainAxisSpacing: 1,
                      // crossAxisSpacing: 1,
                      // childAspectRatio: 1 / 1.7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.width * 0.05,
                        mainAxisSpacing: context.width * 0.1,
                        mainAxisExtent: context.height * 0.4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < cubit.getPlacesEntities.length) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacesDetailes(
                                    placesData: cubit.getPlacesEntities[index],
                                    lat: widget.lat,
                                    long: widget.long,
                                  ),
                                ),
                              );
                            },
                            child: PlacesGridView(
                              cubit.getPlacesEntities[index],
                              context,
                            ),
                          );
                        } else {
                          return Container(); // Return an empty container for indexes out of range.
                        }
                      },
                      itemCount: cubit.getPlacesEntities.length,
                      // itemCount: 10,
                      // children: List.generate(PlacesList.length,
                      //     (index) => PlacesGridView(PlacesList[index], context)),
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }

  void showDialogBox() => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('No Connection'),
          content: Text('Please check your internet connectivitu'),
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

class PlacesIconsModel {
  final String icon;
  final String title;
  final int id;

  PlacesIconsModel({
    required this.icon,
    required this.title,
    required this.id,
  });
}

PlacesGridView(
  GetPlacesEntities PlacesIconModel,
  BuildContext context,
) {
  final bool isLocalImage =
      PlacesIconModel.images.first.url.contains('http://localhost/storage/') ||
          PlacesIconModel.images.first.url.isEmpty;
  // final bool isNullImage = PlacesIconModel.image.contains('');
  return Container(
    // height: context.height * 0.5,
    // width: context.width * 0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey, width: 2),
      color: Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        //   ),
        //   child: Image.asset(
        //     PlacesIconModel.icon,
        //     height: context.height * 0.2,
        //     width: context.width * .7,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        Stack(
          children: [
            Container(
              height: context.height * 0.3,
              width: context.width * 8,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: isLocalImage
                    ? flutter.Image(
                        image: AssetImage(
                          homeImage,
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : flutter.Image(
                        image: NetworkImage(
                          PlacesIconModel.images.first.url,
                        ),
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                // Image.asset(
                //   PlacesIconModel.image,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.blue.shade300,
                ),
                child: IconButton(
                    onPressed: () {
                      NavTo(
                          context,
                          QRCodeGeneratorPlacesScreen(
                            url: BlocProvider.of<LocaleCubit>(context)
                                        .currentLangCode ==
                                    AppStrings.englishCode
                                ? PlacesIconModel.webUrlEn
                                : PlacesIconModel.webUrlAr,
                            placesIconModel: PlacesIconModel,
                          ));
                    },
                    icon: Icon(
                      Icons.qr_code,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.height * 0.013,
        ),
        Center(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: context.height * 0.08,
              width: context.width * .3,
              child: Center(
                child: Text(
                  BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                          AppStrings.englishCode
                      ? PlacesIconModel.titleEN
                      : PlacesIconModel.titleAR,
                  style: const TextStyle(
                      color: Colors.black,
                      // fontSize: context.height * 0.017,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
