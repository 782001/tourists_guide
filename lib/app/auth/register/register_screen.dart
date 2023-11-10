// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:tourist_guide/core/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/locale/app_localizations.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../localization/presentation/screens/splash.dart';
import '../login/login_screen.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        // if (state is RegisterSuccessState) {
        //   NavAndFinish(context, HomeScreen());
        // ShowToust(Text: 'البريد الالكترونيد', state: ToustStates.ERROR);
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
        // } else {
        //   ShowToust(
        //       Text:
        //           'البريد الالكتروني غير صحيح او تم تسجيله من قبل برجاء التأكد',
        //       state: ToustStates.ERROR);
        // }

        if (state is CreateUserSuccessState) {
          // CashHelper.SaveData(
          //   key: 'uId',
          //   value: state.uId,
          // ).then((value) {
          //   NavAndFinish(
          //     context,
          //     const HomeScreen(),
          //   );
          // });
          NavAndFinish(
            context,
            const HomeScreen(),
          );
        }
        // if (state is RegisterErrorState) {
        //   ShowToust(
        //     Text: state.error,
        //     state: ToustStates.ERROR,
        //   );
        // }
      },
      builder: (context, state) {
        return Stack(
          children: [
            const SignINBackground(),
            Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: AppBar(
              //   backgroundColor: Color.fromARGB(255, 58, 192, 176),
              // ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _buildTitle(AppLocalizations.of(context)!
                          //     .translate('CreateAccountNow')!),
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
                                        .translate('CreateAccount')!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xff00008B),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.white,
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    onTap: () {},
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .translate('please_enterName')!;
                                      } else if (value.length < 3) {
                                        return AppLocalizations.of(context)!
                                            .translate(
                                                'please_enterNameMore_3')!;
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          context: context,
                                          // phone: phoneController.text,
                                        );
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.text_fields_rounded,
                                        color: Colors.white,
                                      ),
                                      labelText: AppLocalizations.of(context)!
                                          .translate('name')!,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffE2725B)),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // errorBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: Colors.white,
                                      //   ),
                                      //   gapPadding: 5,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
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
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    onTap: () {},
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .translate('please_enteremail')!;
                                      } else if (!RegisterCubit.get(context)
                                          .legalEmail(emailController.text)) {
                                        return AppLocalizations.of(context)!
                                            .translate(
                                                'please_enterCorrectEmail')!;
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          // phone: phoneController.text,
                                        );
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      labelText: AppLocalizations.of(context)!
                                          .translate('email'),
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffE2725B)),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // errorBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: Colors.white,
                                      //   ),
                                      //   gapPadding: 5,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
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
                                    obscureText: RegisterCubit.get(context)
                                        .isPasswordShow,
                                    onFieldSubmitted: (value) {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).userRegister(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          // phone: phoneController.text,
                                        );
                                      }
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .translate('please_enterPass');
                                      } else if (value.length < 9) {
                                        return AppLocalizations.of(context)!
                                            .translate(
                                                'please_enterPassMore_9');
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
                                        icon: RegisterCubit.get(context).suffix,
                                        onPressed: () {
                                          RegisterCubit.get(context)
                                              .ChangeRegisterPaswordVisibility();
                                        },
                                      ),
                                      labelText: AppLocalizations.of(context)!
                                          .translate('password'),
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffE2725B)),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      // errorBorder: OutlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //     color: Colors.white,
                                      //   ),
                                      //   gapPadding: 5,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),

                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                        gapPadding: 5,
                                        borderRadius: BorderRadius.circular(10),
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
                                  ConditionalBuilder(
                                    condition: state is! RegisterLoadingState,
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
                                            RegisterCubit.get(context)
                                                .userRegister(
                                              context: context,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              // phone: phoneController.text,
                                            )
                                                .then((value) {
                                              NavAndFinish(
                                                  context, LoginScreen());
                                              ShowToust(
                                                  Text: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'RegiserDone')!,
                                                  state: ToustStates.SUCSESS);
                                            });
                                          }
                                        },
                                        child: AutoSizeText(
                                          AppLocalizations.of(context)!
                                              .translate('CreateAccount')!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                            color: Color(0xffE2725B))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
