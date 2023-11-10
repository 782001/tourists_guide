import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/locale/app_localizations.dart';
import '../../../core/network/local/cashhelper.dart';
import '../../../core/utils/assets_images_path.dart';
import '../../../core/utils/components.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../register/register_screen.dart';
import '../reset_password/screen/reset_screen.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        // if (state is LoginErrorState) {
        //   ShowToust(Text: state.error, state: ToustStates.ERROR);
        // if (state.loginModel.status) {
        //   CashHelper.SaveData(
        //           key: 'token', value: state.loginModel.data!.token)
        //       .then((value) {
        //     token = state.loginModel.data!.token;
        //     print('save token');
        //     NavAndFinish(context, HomeScreen());
        //     ShowToust(
        //         Text: state.loginModel.message, state: ToustStates.SUCSESS);
        //   });
        // } else {
        //   ShowToust(
        //       Text: state.loginModel.message, state: ToustStates.ERROR);
        // }
        // } else if (state is LoginSucssesState) {
        //   NavAndFinish(context, HomeScreen());
        // }
        if (state is LoginSucssesState) {
          CashHelper.SaveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            NavAndFinish(
              context,
              const HomeScreen(),
            );
          });
        }
        if (state is LoginErrorState) {
          ShowToust(
            Text: state.error,
            state: ToustStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Stack(
          children: [
            const SignINBackground(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20.0, bottom: 20, end: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: context.height * 0.3,
                            //   width: double.infinity,
                            //   child: Image.asset(
                            //     loginImage,
                            //   ),
                            // ),
                            // _buildTitle(
                            //     AppLocalizations.of(context)!.translate('logIn')!),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20)),
                                // border: Border.all(
                                //     color: Color.fromARGB(255, 221, 171, 239),
                                //     width: 4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      AppLocalizations.of(context)!
                                          .translate('logInNow')!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Color(0xff00008B),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      onTap: () {},
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate('please_enteremail')!;
                                        } else if (!LoginCubit.get(context)
                                            .legalEmail(emailController.text)) {
                                          return AppLocalizations.of(context)!
                                              .translate(
                                                  'please_enterCorrectEmail')!;
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (value) {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).UserLogin(
                                              context: context,
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        labelText: AppLocalizations.of(context)!
                                            .translate('email')!,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        // border: OutlineInputBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(10),
                                        // ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffE2725B)),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // errorBorder: OutlineInputBorder(
                                        //   borderSide: BorderSide(
                                        //     color: Colors.white,
                                        //   ),
                                        //   gapPadding: 5,
                                        //   borderRadius:
                                        //       BorderRadius.circular(10),
                                        // ),

                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // Change the color as desired

                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      cursorColor: Colors.white,
                                      obscureText: LoginCubit.get(context)
                                          .isPasswordShow,
                                      onFieldSubmitted: (value) {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).UserLogin(
                                              context: context,
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .translate('please_enterPass')!;
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: LoginCubit.get(context).suffix,
                                          onPressed: () {
                                            LoginCubit.get(context)
                                                .ChangePaswordVisibility();
                                          },
                                        ),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: AppLocalizations.of(context)!
                                            .translate('password')!,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffE2725B)),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // errorBorder: OutlineInputBorder(
                                        //   borderSide: BorderSide(
                                        //     color: Colors.white,
                                        //   ),
                                        //   gapPadding: 5,
                                        //   borderRadius:
                                        //       BorderRadius.circular(10),
                                        // ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                          gapPadding: 5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // Change the color as desired

                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        String email =
                                            emailController.text.trim();
                                        if (email.isNotEmpty) {
                                          FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                  email: email)
                                              .then((value) {
                                            ShowToust(
                                              // Text: "resetPasswordEmailSent",
                                              Text: AppLocalizations.of(
                                                      context)!
                                                  .translate(
                                                      'resetPasswordEmailSent')!,
                                              state: ToustStates.SUCSESS,
                                            );
                                          }).catchError((error) {
                                            ShowToust(
                                              Text: error.toString(),
                                              state: ToustStates.ERROR,
                                            );
                                          });
                                        } else {
                                          NavTo(context, ResetPasswordScreen());
                                        }
                                      },
                                      child: AutoSizeText(
                                        // "forgotPassword",
                                        AppLocalizations.of(context)!
                                            .translate('forgot_password')!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.of(context)
                                    //         .push(MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ForgotPasswordScreen(),
                                    //     ));
                                    //   },
                                    //   child: Text(
                                    //     // AppLocalizations.of(context)!
                                    //     //     .translate('forgot_password')!,
                                    //     "forgot_password",
                                    //     style: const TextStyle(
                                    //       color: Colors.blue,
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ConditionalBuilder(
                                      condition: state is! LoginLodingState,
                                      builder: (context) => Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Color(0xffE2725B)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).UserLogin(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                            }
                                          },
                                          child: AutoSizeText(
                                            AppLocalizations.of(context)!
                                                .translate('log')!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      fallback: (context) => const Center(
                                          child: CircularProgressIndicator(
                                              color: Color(0xffE2725B))),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          AppLocalizations.of(context)!
                                              .translate('haveNoAccount')!,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            NavTo(context, RegisterScreen());
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .translate('CreateAccount')!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff00008B),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.grey[200],
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('or')!,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.grey[200],
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () async {
                                    await cubit.signInWithGoogle(context);
                                  },
                                  child: OutLineB(
                                      text: AppLocalizations.of(context)!
                                          .translate('GooglelogIn')!,
                                      icon: googleImage),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  // highlightColor: const Color(0xffF89368),
                                  onTap: () async {
                                    await cubit.signInWithTwitter(context);
                                  },
                                  child: OutLineB(
                                      text: AppLocalizations.of(context)!
                                          .translate('FaceBooklogIn')!,
                                      icon: twitterImage),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SignINBackground extends StatelessWidget {
  const SignINBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Image.asset(
      'assets/images/background.jpg',
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
    );
  }
}

Widget _buildTitle(String text) {
  return Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 58, 192, 176),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: AutoSizeText(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}
