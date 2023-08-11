// class CharactersRepository extends CharactersBaseRepository {
//   final GetCharactersBaseRemoteDataSource charactersBaseRemoteDataSource;

//   CharactersRepository({required this.charactersBaseRemoteDataSource});

//   @override
//   Future<Either<dynamic, GetBCharactersModel>> getCharacters() async {
//     try {
//       var response = await charactersBaseRemoteDataSource.getCharactersDataSource(
//           );
//       return Right(response);
//     } catch (e) {
//       return Left(NetworkExceptions.getDioException(e));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:tourist_guide/app/home/characters/data/data_sources/remote_characters_data_source.dart';
import 'package:tourist_guide/app/home/characters/data/model/get_characters_model.dart';

import '../../../../../core/errors/network_exception.dart';
import 'package:tourist_guide/app/home/characters/domain/base_repository/characters_base_repository.dart';

class CharactersRepository extends CharactersBaseRepository {
  final GetCharactersBaseRemoteDataSource charactersBaseRemoteDataSource;

  CharactersRepository(
    this.charactersBaseRemoteDataSource,
  );
  @override
  Future<Either<dynamic, List<GetCharactersModel>>> getCharacters() async {
    try {
      var response =
          await charactersBaseRemoteDataSource.getCharactersDataSource();
      return Right(response!);
    } catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    }
  }
}
