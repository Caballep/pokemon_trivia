import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';

abstract class RegionOptionState {}

class RegionOptionInitialState extends RegionOptionState {}

class RegionOptionLoadingState extends RegionOptionState {}

class RegionOptionLoadedState extends RegionOptionState {
  final RegionOptionData regionOptionData;

  RegionOptionLoadedState(this.regionOptionData);
}

class RegionOptionErrorState extends RegionOptionState {
  final String errorMessage;

  RegionOptionErrorState(this.errorMessage);
}
