import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/result_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GetGenerationsUC {
  final GenerationRepository _generationRepository;
  final ResultHandler _resultHandler;

  GetGenerationsUC(
      {required GenerationRepository generationRepository, required ResultHandler resultHandler})
      : _generationRepository = generationRepository,
        _resultHandler = resultHandler;

  Future<Outcome<List<GenerationModel>?>> invoke() async {
    final result = await _generationRepository.getGenerations();
    final resultError = _resultHandler.handle(result, errorWhenNull: true);
    if (resultError != null) {
      return ErrorOutcome(resultError);
    }

    return SuccessOutcome(result.data!);
  }
}
