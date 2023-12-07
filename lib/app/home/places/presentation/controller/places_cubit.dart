import 'package:tourist_guide/app/home/places/presentation/controller/places_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base_usecase/base_usecase.dart';
import '../../domain/entity/get_places_entities.dart';
import '../../domain/usecases/get_places_usecase.dart';

class PlacesCubit extends Cubit<PlacesStates> {
  // final GetPlacesUseCase getPlacesUseCase;
  final GetPlacesUseCase getplacesUseCase;
  PlacesCubit({required this.getplacesUseCase}) : super(InitialState());
  static PlacesCubit get(context) => BlocProvider.of(context);

  List<GetPlacesEntities> getPlacesEntities = [];
  Future getPlaces() async {
    emit(PlacesLoadingState());
    var response = await getplacesUseCase(
      const NoParemeters(),
    );
    print(response);
    response.fold((l) {
      emit(PlacesErrorState(message: l));
    }, (r) {
      getPlacesEntities = r;
      print(
          "${getPlacesEntities.length};lerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(PlacesSucsessState());
    });
  }
}
