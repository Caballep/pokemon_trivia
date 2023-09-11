import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option_data.dart';

abstract class RegionOptionState {}

class RegionOptionInitialState extends RegionOptionState {}

class RegionOptionLockedOrAvailableState extends RegionOptionState {
  final RegionOptionLockedOrAvailableData regionOptionData;

  RegionOptionLockedOrAvailableState(this.regionOptionData);
}

class RegionOptionReadyToPlayState extends RegionOptionState {
  final RegionOptionReadyToPlayData regionOptionData;

  RegionOptionReadyToPlayState(this.regionOptionData);
}

class RegionOptionErrorState extends RegionOptionState {
  final String errorMessage;

  RegionOptionErrorState(this.errorMessage);
}
