abstract class CharactersStates {}

class InitialState extends CharactersStates {}

class CharactersLoadingState extends CharactersStates {}

class CharactersSucsessState extends CharactersStates {}

class CharactersErrorState extends CharactersStates {
  final dynamic message;

  CharactersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChangeDialogState extends CharactersStates {}
