// import '../../domain/entity/get_characters.dart';

// class GetCharactersModel extends GetCharactersEntities {
//   const GetCharactersModel({
//     required super.CharactersId,
//     required super.name_En,
//     required super.description_En,
//     required super.name_Ar,
//     required super.description_Ar,
//     required super.CharactersImage,
//   });
//   factory GetCharactersModel.fromJson(Map<String, dynamic> json) {
//     return GetCharactersModel(
//       CharactersId: json['id'],
//       name_En: json['name En'],
//       description_En: json['description En'],
//       name_Ar: json['name Ar'],
//       description_Ar: json['description Ar'],
//       CharactersImage: json['image'],
//     );
//   }
// }

import '../../domain/entity/get_characters_entities.dart';

// class GetCharctersModel extends GetCharactersEntities  {
//   bool? success;
//   List<Data>? data;
//   String? message;

//   // GetCharactersModel({this.success, this.data, this.message});
//    GetCharactersModel({

//     required super.success,
//     required super.data,
//     required super.messag,

//   });
// factory GetCharactersModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//      data: List<CharactersDataModel>.from(
//         (json['data'] as List).map(
//           (x) => CharactersDataModel.fromJson(x),
//         ),
//       ),
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
// }

// class Data {
//   int? id;
//   String? nameEn;
//   String? descriptionEn;
//   String? nameAr;
//   String? descriptionAr;
//   String? image;

//   Data(
//       {this.id,
//       this.nameEn,
//       this.descriptionEn,
//       this.nameAr,
//       this.descriptionAr,
//       this.image});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameEn = json['name En'];
//     descriptionEn = json['description En'];
//     nameAr = json['name Ar'];
//     descriptionAr = json['description Ar'];
//     image = json['image'];
//   }
// }

class GetCharactersModel extends GetCharactersEntities {
  GetCharactersModel({
    // required super.data,
    // required super.message,
    // required super.success,
    required super.id,
    required super.audio_AR,
    required super.audio_En,
    required super.nameEn,
    required super.descriptionEn,
    required super.nameAr,
    required super.descriptionAr,
    required super.image,
  });

  factory GetCharactersModel.fromJson(Map<String, dynamic> json) {
    return GetCharactersModel(
      // success: json['success'],
      // message: json['message'],
      // data: List<DataCharactersModel>.from(
      //   (json['data'] as List).map(
      //     (x) => DataCharactersModel.fromJson(x),
      //   ),
      // ),
      id: json['id'],
      nameEn: json['name En'],
      descriptionEn: json['description En'],
      nameAr: json['name Ar'],
      descriptionAr: json['description Ar'],
      image: json['image'],
      audio_AR: json['audio ar'],
      audio_En: json['audio en'],
    );
  }
}
