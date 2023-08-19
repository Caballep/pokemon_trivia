import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GetGenerationUC {
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  GetGenerationUC(
      {required GenerationRepository generationRepository, required ResultHandler resultHandler})
      : _generationRepository = generationRepository,
        _resultHandler = resultHandler;

  Future<Outcome<GenerationModel?>> invoke(String generationCode) async {
    final getGenerationResult = await _generationRepository.getGeneration(generationCode);
    final getGenerationResultError = _resultHandler.handle(getGenerationResult);
    if (getGenerationResultError != null) {
      return ErrorOutcome(getGenerationResultError);
    }
    final generation = getGenerationResult.data!;

    return SuccessOutcome(generation);
  }
}
