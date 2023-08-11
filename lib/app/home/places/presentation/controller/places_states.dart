abstract class PlacesStates {}

class InitialState extends PlacesStates {}

class PlacesLoadingState extends PlacesStates {}

class PlacesSucsessState extends PlacesStates {}

class PlacesErrorState extends PlacesStates {
  final dynamic message;

  PlacesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ChangeDialogState extends PlacesStates {}
