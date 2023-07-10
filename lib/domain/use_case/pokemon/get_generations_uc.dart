import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/domain/helper/exception_handler.dart';
import 'package:pokemon_trivia/domain/helper/outcome.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GetGenerationsUC {
  final GenerationRepository _generationRepository;
  final ExceptionHandler _exceptionHandler;

  GetGenerationsUC(
      {required GenerationRepository generationRepository,
      required ExceptionHandler exceptionHandler})
      : _generationRepository = generationRepository,
        _exceptionHandler = exceptionHandler;

  Future<Outcome<List<GenerationModel>?>> invoke() async {
    final result = await _generationRepository.getGenerations();

    if (result.isError) {
      final error = _exceptionHandler.handleAndGetError(result.exceptionData!);
      return ErrorOutcome(error);
    }

    return SuccessOutcome(result.data!);
  }
}
