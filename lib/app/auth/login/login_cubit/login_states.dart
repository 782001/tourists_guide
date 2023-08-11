class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLodingState extends LoginStates {}

class LoginSucssesState extends LoginStates {
  final String uId;

  LoginSucssesState(this.uId);
}

class LoginChangePaswordVisibilityState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
