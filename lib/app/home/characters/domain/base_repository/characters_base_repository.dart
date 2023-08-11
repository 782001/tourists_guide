import 'package:dartz/dartz.dart';

import '../entity/get_characters_entities.dart';

abstract class CharactersBaseRepository {
  Future<Either<dynamic, List<GetCharactersEntities>>> getCharacters();
}
