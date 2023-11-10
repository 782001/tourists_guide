import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tourist_guide/app/home/places/domain/entity/get_places_entities.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../localization/presentation/cubit/locale_cubit.dart';

class QRCodeGeneratorScreen extends StatelessWidget {
  final String url;
  final GetPlacesEntities placesIconModel;

  QRCodeGeneratorScreen({
    required this.url,
    required this.placesIconModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios_new,
        //     color: Colors.blue.shade900,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: AutoSizeText(
          BlocProvider.of<LocaleCubit>(context).currentLangCode ==
                  AppStrings.englishCode
              ? placesIconModel.titleEN
              : placesIconModel.titleAR,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(height: 20),
            QrImageView(
              data: url,
              version: QrVersions.auto,
              size: 200,
            ),
            Text(
              "Scan Qr Code ",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
