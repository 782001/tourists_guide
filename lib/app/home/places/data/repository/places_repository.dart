// class PlacesRepository extends PlacesBaseRepository {
//   final GetPlacesBaseRemoteDataSource PlacesBaseRemoteDataSource;

//   PlacesRepository({required this.PlacesBaseRemoteDataSource});

//   @override
//   Future<Either<dynamic, GetBPlacesModel>> getPlaces() async {
//     try {
//       var response = await PlacesBaseRemoteDataSource.getPlacesDataSource(
//           );
//       return Right(response);
//     } catch (e) {
//       return Left(NetworkExceptions.getDioException(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/network_exception.dart';

import '../../domain/base_repository/places_base_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../model/get_places_model.dart';

class PlacesRepository extends PlacesBaseRepository {
  final GetPlacesBaseRemoteDataSource placesBaseRemoteDataSource;

  PlacesRepository(
    this.placesBaseRemoteDataSource,
  );
  @override
  Future<Either<dynamic, List<GetPlacesModel>>> getPlaces() async {
    try {
      var response = await placesBaseRemoteDataSource.getPlacesDataSource();
      return Right(response!);
    } catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    }
  }
}
