abstract class HomeStates {}

class InitialState extends HomeStates {}

class CharactersLoadingState extends HomeStates {}

class CharactersSucsessState extends HomeStates {}

class CharactersErrorState extends HomeStates {
  final String message;

  CharactersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChangeDialogState extends HomeStates {}
