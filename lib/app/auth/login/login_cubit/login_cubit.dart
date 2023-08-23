import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/network/local/cashhelper.dart';
import '../../../../core/utils/components.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'login_states.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  // void UserLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLodingState());
  //   // DioHelper.Postdata(
  //   //     url: LOGIN,
  //   //     data: {
  //   //       "email":email,
  //   //       "password":password
  //   //     }
  //   // ).then((value) {
  //   //   print(value.data);
  //   //   loginModel= LoginModel.FromJson(value.data);
  //   //   emit(LoginSucssesState(loginModel!));
  //   //     }
  //   //     )
  //   //     .catchError((error){
  //   //    emit(LoginErrorState( error));
  //   //    print(error.message());
  //   // })
  //   // ;
  // }
  String? errorMessage;
  void UserLogin({
    required String email,
    required String password,
    required context,
  }) async {
    // emit(LoginLodingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print('loginnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        emit(LoginSucssesState(value.user!.uid));
      });
      // .catchError((error) {
      //   emit(LoginErrorState(error.toString()));
      //   ShowToust(Text: error.toString(), state: ToustStates.ERROR);
      //   print('erooorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${error.toString()}');
      // });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage =
              AppLocalizations.of(context)!.translate('invalid-email')!;
          break;
        case "wrong-password":
          errorMessage =
              AppLocalizations.of(context)!.translate('wrong-password')!;
          break;
        case "user-not-found":
          errorMessage =
              AppLocalizations.of(context)!.translate('user-not-found')!;
          break;
        case "email-already-in-use":
          errorMessage =
              AppLocalizations.of(context)!.translate('email-already-in-use')!;
          break;
        case "user-disabled":
          errorMessage =
              AppLocalizations.of(context)!.translate('user-disabled')!;
          break;
        case "too-many-requests":
          errorMessage =
              AppLocalizations.of(context)!.translate('too-many-requests')!;
          break;
        case "operation-not-allowed":
          errorMessage =
              AppLocalizations.of(context)!.translate('operation-not-allowed')!;
          break;
        default:
          errorMessage =
              AppLocalizations.of(context)!.translate('default_errorMessage')!;
      }
      ShowToust(Text: errorMessage!, state: ToustStates.ERROR);
    }
  }

  Icon suffix = const Icon(
    Icons.remove_red_eye,
    color: Colors.white,
  );
  bool isPasswordShow = true;

  void ChangePaswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? const Icon(
            Icons.remove_red_eye,
            color: Colors.white,
          )
        : const Icon(
            Icons.visibility_off,
            color: Colors.white,
          );
    emit(LoginChangePaswordVisibilityState());
  }

  bool emailValid = false;
  bool legalEmail(String email) {
    return emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<UserCredential> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    CashHelper.SaveData(
      key: 'uId',
      value: googleAuth?.idToken,
    ).then((value) {
      ShowToust(
        Text: AppLocalizations.of(context)!.translate('logInDone')!,
        state: ToustStates.SUCSESS,
      );
      NavAndFinish(
        context,
        const HomeScreen(),
      );
    });
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook(context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    CashHelper.SaveData(
      key: 'uId',
      value: loginResult.accessToken!.token,
    ).then((value) {
      ShowToust(
        Text: AppLocalizations.of(context)!.translate('logInDone')!,
        state: ToustStates.SUCSESS,
      );
      NavAndFinish(
        context,
        const HomeScreen(),
      );
    });
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter(context) async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'kMnyVvb7cAKWHDcZpWmuonbAl',
        apiSecretKey: '1H70bojwWWkb7LCJgzcgfn6oFbzbqLXNiV2LCyDXH7EHpVryAE',
        redirectURI:
            'https://tourist-guide-94254.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    CashHelper.SaveData(
      key: 'uId',
      value: authResult.authToken!,
    ).then((value) {
      ShowToust(
        Text: AppLocalizations.of(context)!.translate('logInDone')!,
        state: ToustStates.SUCSESS,
      );
      NavAndFinish(
        context,
        const HomeScreen(),
      );
    });
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }
}

// void signUp(String email, String password) async {
//     if (GlobalKey<FormState>().currentState!.validate()) {
//       try {
//         await FirebaseAuth.instance //<--- Error stops here
//             .createUserWithEmailAndPassword(email: email, password: password)
//             .then((value) => {postDetailsToFirestore()})
//             .catchError((e) {
//           Fluttertoast.showToast(msg: e!.message);
//         });
//       } on FirebaseAuthException catch (error) {
//         switch (error.code) {
//           case "invalid-email":
//             errorMessage = "Your email address appears to be incorrect.";
//             break;
//           case "wrong-password":
//             errorMessage = "Your password is wrong.";
//             break;
//           case "user-not-found":
//             errorMessage = "User with this email doesn't exist.";
//             break;
//           case "user-disabled":
//             errorMessage = "User with this email has been disabled.";
//             break;
//           case "too-many-requests":
//             errorMessage = "Too many requests";
//             break;
//           case "operation-not-allowed":
//             errorMessage = "Signing in with Email and Password is not enabled.";
//             break;
//           default:
//             errorMessage = "An undefined Error happened.";
//         }
//         Fluttertoast.showToast(msg: errorMessage!);
//         print(error.code);
//       }
//     }
//   }
