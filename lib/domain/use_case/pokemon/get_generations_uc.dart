import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GetGenerationsUC {
  final GenerationRepository _generationRepository;

  GetGenerationsUC({required GenerationRepository generationRepository})
      : _generationRepository = generationRepository;

  Future<Result<List<GenerationModel>>> invoke() async {
    return _generationRepository.getGenerations();
  }
}
