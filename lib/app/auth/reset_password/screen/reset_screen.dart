import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/components.dart';
import '../reset_cubit/reset_cubit.dart';
import '../reset_cubit/reset_states.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          ShowToust(
            Text: AppLocalizations.of(context)!
                .translate('resetPasswordEmailSent')!,
            state: ToustStates.SUCSESS,
          );
          Navigator.of(context).pop();
        } else if (state is ResetPasswordErrorState) {
          ShowToust(
            Text: state.error!,
            state: ToustStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   //   title: Text(
          //   //     "resetPassword",
          //   //     // AppLocalizations.of(context)!
          //   //     // .translate('resetPassword')!,
          //   //   ),
          // ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Form(
                  key: formKey,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: context.height * .1,
                        ),
                        AutoSizeText(
                          // "resetPasswordInstructions",
                          AppLocalizations.of(context)!
                              .translate('resetPassword')!,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: context.height * .03,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('email')!,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              // return "please_enter_email";
                              return AppLocalizations.of(context)!
                                  .translate('please_enteremail')!;
                            }
                            return null;
                          },
                          // decoration: InputDecoration(
                          //   labelText:
                          //       AppLocalizations.of(context)!.translate('email')!,
                          //   border: OutlineInputBorder(),
                          // ),
                        ),
                        SizedBox(
                          height: context.height * .03,
                        ),
                        ConditionalBuilder(
                          condition: state is! ResetPasswordLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffE2725B)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                //padding: EdgeInsets.all(10.0),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffE2725B)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(color: Colors.white)),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  (Set<MaterialState> states) {
                                    // if the button is pressed the elevation is 10.0, if not
                                    // it is 5.0
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return 10.0;
                                    }
                                    return 0;
                                  },
                                ),
                                // textColor: Colors.white,
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(
                                          color: Color(0xffE2725B), width: 2)),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ResetPasswordCubit.get(context).resetPassword(
                                    email: emailController.text.trim(),
                                  );
                                }
                              },
                              child: Text(
                                // "resetPassword",
                                AppLocalizations.of(context)!
                                    .translate('reset')!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xffE2725B)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
