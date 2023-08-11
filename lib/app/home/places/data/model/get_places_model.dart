// import '../../domain/entity/get_Places.dart';

// class GetPlacesModel extends GetPlacesEntities {
//   const GetPlacesModel({
//     required super.PlacesId,
//     required super.name_En,
//     required super.description_En,
//     required super.name_Ar,
//     required super.description_Ar,
//     required super.PlacesImage,
//   });
//   factory GetPlacesModel.fromJson(Map<String, dynamic> json) {
//     return GetPlacesModel(
//       PlacesId: json['id'],
//       name_En: json['name En'],
//       description_En: json['description En'],
//       name_Ar: json['name Ar'],
//       description_Ar: json['description Ar'],
//       PlacesImage: json['image'],
//     );
//   }
// }

import '../../domain/entity/get_places_entities.dart';

// class GetCharctersModel extends GetPlacesEntities  {
//   bool? success;
//   List<Data>? data;
//   String? message;

//   // GetPlacesModel({this.success, this.data, this.message});
//    GetPlacesModel({

//     required super.success,
//     required super.data,
//     required super.messag,

//   });
// factory GetPlacesModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//      data: List<PlacesDataModel>.from(
//         (json['data'] as List).map(
//           (x) => PlacesDataModel.fromJson(x),
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

class GetPlacesModel extends GetPlacesEntities {
  const GetPlacesModel({
    // required super.data,
    // required super.message,
    // required super.success,
    required super.id,
    required super.audio_Ar,
    required super.audio_En,
    required super.descriptionAR,
    required super.titleAR,
    required super.descriptionEN,
    required super.images,
    required super.lat,
    required super.lng,
    required super.titleEN,
  });

  factory GetPlacesModel.fromJson(Map<String, dynamic> json) {
    return GetPlacesModel(
      // success: json['success'],
      // message: json['message'],
      // data: List<DataPlacesModel>.from(
      //   (json['data'] as List).map(
      //     (x) => DataPlacesModel.fromJson(x),
      //   ),
      // ),
      id: json['id'],
      titleEN: json['title EN'],
      descriptionEN: json['description EN'],
      titleAR: json['title AR'],
      descriptionAR: json['description AR'],
      lat: json['lat'],
      lng: json['lng'],
      audio_Ar: json['audio ar'],
      audio_En: json['audio en'],
      images: (json['images'] as List<dynamic>)
          .map((imageJson) => Image(
                url: imageJson['url'],
              ))
          .toList(),
    );
  }
}
