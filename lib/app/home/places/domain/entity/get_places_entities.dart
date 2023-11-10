import 'package:equatable/equatable.dart';

class GetPlacesEntities extends Equatable {
  final int id;
  final String titleEN;
  final String descriptionEN;
  final String titleAR;
  final String webUrlEn;
  final String webUrlAr;

  final String descriptionAR;
  final String lat;
  final String lng;
  final String audio_En;
  final String audio_Ar;
  final List<Image> images;
  const GetPlacesEntities({
    required this.id,
    required this.titleEN,
    required this.descriptionEN,
    required this.titleAR,
    required this.webUrlEn,
    required this.webUrlAr,
    required this.descriptionAR,
    required this.lat,
    required this.lng,
    required this.audio_En,
    required this.audio_Ar,
    required this.images,
  });
  // const GetPlaces({
  //   required this.PlacesId,
  //   required this.PlacesId,
  //   required this.PlacesName,
  //   required this.PlacesDescription,
  //   required this.PlacesPrice,
  //   required this.PlacesAddress,
  //   required this.PlacesLongitude,
  //   required this.PlacesLatitude,
  //   required this.PlacesRate,
  //   required this.PlacesImages,
  //   required this.facilities,
  // });

  @override
  List<Object?> get props {
    return [
      id,
      titleEN,
      descriptionEN,
      titleAR,
      descriptionAR,
      lat,
      lng,
      audio_Ar,
      audio_En,
      webUrlAr,
      webUrlEn,
      images,
    ];
  }
}

class Image {
  final String url;

  Image({
    required this.url,
  });
}
