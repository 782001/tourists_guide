import 'package:dio/dio.dart';

import '../../../../../core/network/api_constance.dart';
import '../model/get_places_model.dart';

abstract class GetPlacesBaseRemoteDataSource {
  Future<List<GetPlacesModel>?> getPlacesDataSource({
    String? base,
    String? endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });
}

const apiUrl = 'http://localhost/places/public/api/Places';

class GetPlacesRemoteDataSource extends GetPlacesBaseRemoteDataSource {
  @override
  Future<List<GetPlacesModel>?> getPlacesDataSource(
      {String? base,
      String? endPoint,
      data,
      query,
      String? token,
      CancelToken? cancelToken,
      int? timeOut,
      bool isMultipart = false}) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(milliseconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'token': token,
    };

    // debugPrint('URL => ${dio.options.baseUrl + endPoint!}');
    // debugPrint('Header => ${dio.options.headers.toString()}');
    // debugPrint('Body => $data');
    // debugPrint('Query => $query');

    var response = await dio.get(
      ApiConstance.placesEndPoint,
      // queryParameters: {},
    );
    if (response.statusCode == 200) {
      print(response);
      final data = response.data['data'] as List<dynamic>?;

      return data!.map((json) => GetPlacesModel.fromJson(json)).toList();
      // return GetPlacesModel.fromJson(response.data['data']);
    } else {
      throw Exception();
      // throw Exception('No data in response');
    }
  }
}
