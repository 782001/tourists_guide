import 'package:dio/dio.dart';
import 'package:tourist_guide/app/home/characters/presentation/controller/characters_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:tourist_guide/app/localization/data/datasources/lang_local_data_source.dart';
import 'package:tourist_guide/app/localization/data/repositories/lang_repository_impl.dart';
import 'package:tourist_guide/app/localization/domain/repositories/lang_repository.dart';
import 'package:tourist_guide/app/localization/domain/usecases/change_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_guide/app/localization/presentation/cubit/locale_cubit.dart';
import 'package:tourist_guide/app/localization/domain/usecases/get_saved_lang.dart';

import 'app/home/characters/data/data_sources/remote_characters_data_source.dart';
import 'app/home/characters/data/repository/characters_repository.dart';
import 'app/home/characters/domain/base_repository/characters_base_repository.dart';
import 'app/home/characters/domain/usecases/get_characters_usecase.dart';
import 'app/home/places/data/data_sources/remote_data_source.dart';
import 'app/home/places/data/repository/places_repository.dart';
import 'app/home/places/domain/base_repository/places_base_repository.dart';
import 'app/home/places/domain/usecases/get_places_usecase.dart';
import 'app/home/places/presentation/controller/places_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs

  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));
  sl.registerFactory<CharactersCubit>(() => CharactersCubit(
        getcharactersUseCase: sl(),
      ));
  sl.registerFactory<PlacesCubit>(() => PlacesCubit(
        getplacesUseCase: sl(),
      ));

  // Use cases

  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<GetCharactersUseCase>(
      () => GetCharactersUseCase(charactersBaseRepository: sl()));
  sl.registerLazySingleton<GetPlacesUseCase>(
      () => GetPlacesUseCase(placesBaseRepository: sl()));

  // Repository
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));
  sl.registerLazySingleton<CharactersBaseRepository>(
      () => CharactersRepository(sl()));
  sl.registerLazySingleton<PlacesBaseRepository>(() => PlacesRepository(sl()));

  // Data Sources

  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<GetCharactersBaseRemoteDataSource>(
      () => GetCharactersRemoteDataSource());
  sl.registerLazySingleton<GetPlacesBaseRemoteDataSource>(
      () => GetPlacesRemoteDataSource());

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
