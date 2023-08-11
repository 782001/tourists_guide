import 'package:tourist_guide/core/base_usecase/base_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/get_characters_entities.dart';
import '../../domain/usecases/get_characters_usecase.dart';
import 'characters_states.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  final GetCharactersUseCase getcharactersUseCase;

  CharactersCubit({
    required this.getcharactersUseCase,
  }) : super(InitialState());
  static CharactersCubit get(context) => BlocProvider.of(context);

  List<GetCharactersEntities>? getCharactersEntities;
  Future getCharacters() async {
    emit(CharactersLoadingState());
    var response = await getcharactersUseCase(
      const NoParemeters(),
    );
    print(response);
    response.fold((l) {
      emit(CharactersErrorState(message: l));
    }, (r) {
      getCharactersEntities = r;
      print(
          "${getCharactersEntities!.first.nameEn};lerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      emit(CharactersSucsessState());
    });
  }
}
