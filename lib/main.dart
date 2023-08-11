import 'package:tourist_guide/app/localization/presentation/cubit/locale_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_cubit/cubit.dart';
import 'app/auth/login/login_cubit/login_cubit.dart';
import 'app/auth/login/login_screen.dart';
import 'app/auth/register/register_cubit/register_cubit.dart';
import 'app/auth/reset_password/reset_cubit/reset_cubit.dart';
import 'app/home/characters/presentation/controller/characters_cubit.dart';
import 'app/home/places/presentation/controller/places_cubit.dart';
import 'app/home/presentation/controller/home_cubit.dart';
import 'app/home/presentation/screens/home_screen.dart';
import 'app/localization/presentation/screens/splash.dart';
import 'config/locale/app_localizations_setup.dart';
import 'core/network/local/cashhelper.dart';
import 'core/utils/components.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;
import 'onboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DioHelper.init();
  await di.init();
  // DioHelper.init();
  await Firebase.initializeApp();

  await CashHelper.init();
  Widget widget;
  bool? onBording = CashHelper.GetBoolData(key: 'onBording');
  bool? changeLang = CashHelper.GetBoolData(key: 'changeLang');
//   runApp(const MyApp());
//

  uId = (await CashHelper.GetData(key: 'uId'));
  if (changeLang != null) {
    if (onBording != null) {
      if (uId != null) {
        widget = const HomeScreen();
      } else {
        widget = LoginScreen();
      }
    } else {
      widget = const BordingScreen(
        isFromDrawer: false,
      );
    }
  } else {
    widget = const SplashScreen(
      isFromDrawer: false,
    );
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget StartWidget;

  const MyApp(this.StartWidget, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ResetPasswordCubit()..resetPassword(),
        ),
        BlocProvider(
            create: (context) =>
                PlacesCubit(getplacesUseCase: sl())..getPlaces()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
            create: (context) =>
                CharactersCubit(getcharactersUseCase: sl())..getCharacters()),
        BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.blue.shade900))),
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            // home: LoginScreen(),
            home: StartWidget,
          );
        },
      ),
    );
  }
}
