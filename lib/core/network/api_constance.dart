import 'package:dio/dio.dart';
import 'package:tourist_guide/core/network/status.dart';

// StatusModel? statusModel;
// StatusModel? registerstatusModel;
// StatusProfileInfo? statusProfileInfo;
// StatusModel? updateProfileStatusModel;
String? token;
StatusModel? statusModel;
StatusModel? registerstatusModel;

class ApiConstance {
  static const String baseUrl = 'https://www.joedev.online/api/';
  static const String charactersEndPoint = 'characters.php';
  static const String placesEndPoint = 'places.php';
}

final Dio dio = Dio(
  BaseOptions(
    baseUrl: ApiConstance.baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(milliseconds: 5000),
  ),
);

// abstract class DioHelper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(BaseOptions(
//       baseUrl: ApiConstance.baseUrl,
//       receiveDataWhenStatusError: true,
//     ));
//   }
// }
