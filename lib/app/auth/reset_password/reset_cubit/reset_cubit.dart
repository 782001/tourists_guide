import 'package:tourist_guide/app/auth/reset_password/reset_cubit/reset_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(BuildContext context) =>
      BlocProvider.of<ResetPasswordCubit>(context);

  Future<void> resetPassword({String? email}) async {
    try {
      emit(ResetPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      emit(ResetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(ResetPasswordErrorState(e.message!));
    } catch (e) {
      emit(ResetPasswordErrorState(e.toString()));
    }
  }
}
