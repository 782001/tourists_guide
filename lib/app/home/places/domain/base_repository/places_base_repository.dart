import 'package:dartz/dartz.dart';

import '../entity/get_places_entities.dart';

abstract class PlacesBaseRepository {
  Future<Either<dynamic, List<GetPlacesEntities>>> getPlaces();
}
