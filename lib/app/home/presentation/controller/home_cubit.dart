import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  // final GetCharactersUseCase getcharactersUseCase;
  HomeCubit() : super(InitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
}
