import 'package:equatable/equatable.dart';

class GetCharactersEntities extends Equatable {
  final int id;
  final String nameEn;
  final String descriptionEn;
  final String nameAr;
  final String descriptionAr;
  final String audio_AR;
  final String audio_En;
  final String image;
  final String webUrlEn;
  final String webUrlAr;
  GetCharactersEntities({
    required this.id,
    required this.audio_AR,
    required this.audio_En,
    required this.nameEn,
    required this.descriptionEn,
    required this.nameAr,
    required this.descriptionAr,
    required this.image,
    required this.webUrlEn,
    required this.webUrlAr,
  });
  // const GetCharacters({
  //   required this.CharactersId,
  //   required this.CharactersId,
  //   required this.CharactersName,
  //   required this.CharactersDescription,
  //   required this.CharactersPrice,
  //   required this.CharactersAddress,
  //   required this.CharactersLongitude,
  //   required this.CharactersLatitude,
  //   required this.CharactersRate,
  //   required this.CharactersImages,
  //   required this.facilities,
  // });

  @override
  List<Object?> get props {
    return [
      id,
      nameEn,
      nameAr,
      descriptionAr,
      image,
      descriptionEn,
      audio_AR,
      audio_En,
    ];
  }
}
