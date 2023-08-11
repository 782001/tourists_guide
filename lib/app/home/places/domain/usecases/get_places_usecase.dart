// import 'package:dartz/dartz.dart';

// import '../../../../core/base_usecase/base_usecase.dart';
// import '../base_repository/places_base_repository.dart';
// import '../entity/get_places.dart';

// class GetBookingUseCase extends BaseUseCase<List<GetBooking>, String> {
//   final BookingBaseRepository bookingBaseRepository;

//   GetBookingUseCase({required this.bookingBaseRepository});

//   @override
//   Future<Either<dynamic, List<GetBooking>>> call(String parameters) async {
//     return await bookingBaseRepository.getBooking(type: parameters);
//   }
// }

import 'package:dartz/dartz.dart';

import '../../../../../core/base_usecase/base_usecase.dart';
import '../base_repository/places_base_repository.dart';
import '../entity/get_places_entities.dart';

class GetPlacesUseCase extends BaseUseCase<GetPlacesEntities, NoParemeters> {
  final PlacesBaseRepository placesBaseRepository;

  GetPlacesUseCase({required this.placesBaseRepository});

  @override
  Future<Either<dynamic, List<GetPlacesEntities>>> call(
      NoParemeters parameters) async {
    return await placesBaseRepository.getPlaces();
  }
}
