import 'package:auto_size_text/auto_size_text.dart';
import 'package:tourist_guide/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/local/cashhelper.dart';
import '../../../../core/utils/components.dart';
import '../../../../onboard_screen.dart';
import '../cubit/locale_cubit.dart';

class SplashScreen extends StatefulWidget {
  final bool isFromDrawer;

  const SplashScreen({super.key, required this.isFromDrawer});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isFirstOptionSelected = false;

  void _toggleFirstOption() {
    setState(() {
      _isFirstOptionSelected = true;
    });
  }

  void _toggleSecondOption() {
    setState(() {
      _isFirstOptionSelected = false;
    });
  }

  void Submit() {
    CashHelper.SaveData(key: 'changeLang', value: true).then((value) {
      if (value) {
        print(' changeLang save true');
        // NavAndFinish(context, HomeScreen());
        widget.isFromDrawer
            ? Navigator.pop(context)
            : NavAndFinish(
                context,
                const BordingScreen(
                  isFromDrawer: false,
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _toggleFirstOption,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isFirstOptionSelected
                            ? Color(0xffE2725B)
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: _isFirstOptionSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: _toggleSecondOption,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !_isFirstOptionSelected
                            ? Color(0xffE2725B)
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: !_isFirstOptionSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _isFirstOptionSelected ? 'عربي' : 'English ',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: context.height * 0.01),
              ElevatedButton(
                style: ButtonStyle(
                  //padding: EdgeInsets.all(10.0),
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xffE2725B),
                  ),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white)),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      // if the button is pressed the elevation is 10.0, if not
                      // it is 5.0
                      if (states.contains(MaterialState.pressed)) {
                        return 10.0;
                      }
                      return 0;
                    },
                  ),
                  // textColor: Colors.white,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: Color(0xffE2725B), width: 2)),
                  ),
                ),
                onPressed: () {
                  if (_isFirstOptionSelected) {
                    BlocProvider.of<LocaleCubit>(context).toArabic();
                  } else {
                    BlocProvider.of<LocaleCubit>(context).toEnglish();
                  }
                  Submit();
                },
                child: AutoSizeText(
                  _isFirstOptionSelected ? "فلنبدأ " : "Let’s Go",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(height: context.height * 0.04),
            ],
          ),
        ),
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Image.asset(
      'assets/images/background2.jpg',
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
    );
  }
}
