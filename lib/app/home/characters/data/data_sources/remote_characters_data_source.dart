import 'package:dio/dio.dart';

import '../../../../../core/network/api_constance.dart';
import '../model/get_characters_model.dart';

abstract class GetCharactersBaseRemoteDataSource {
  Future<List<GetCharactersModel>?> getCharactersDataSource({
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

const apiUrl = 'http://localhost/places/public/api/characters';

class GetCharactersRemoteDataSource extends GetCharactersBaseRemoteDataSource {
  @override
  Future<List<GetCharactersModel>?> getCharactersDataSource(
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
      ApiConstance.charactersEndPoint,
      // queryParameters: {},
    );
    if (response.statusCode == 200) {
      print(response);
      final data = response.data['data'] as List<dynamic>?;

      return data!.map((json) => GetCharactersModel.fromJson(json)).toList();
      // return GetCharactersModel.fromJson(response.data['data']);
    } else {
      throw Exception();
      // throw Exception('No data in response');
    }
  }
}
