import 'package:dartz/dartz.dart';

import '../../../../../core/base_usecase/base_usecase.dart';
import '../base_repository/characters_base_repository.dart';
import '../entity/get_characters_entities.dart';

class GetCharactersUseCase
    implements BaseUseCase<GetCharactersEntities, NoParemeters> {
  final CharactersBaseRepository charactersBaseRepository;

  GetCharactersUseCase({required this.charactersBaseRepository});

  @override
  Future<Either<dynamic, List<GetCharactersEntities>>> call(
      NoParemeters parameters) async {
    return await charactersBaseRepository.getCharacters();
  }
}
