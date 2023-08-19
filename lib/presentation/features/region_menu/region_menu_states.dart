import 'package:pokemon_trivia/presentation/features/region_menu/region_menu_data.dart';

abstract class RegionMenuEvent {}

class LoadRegionsEvent extends RegionMenuEvent {}

class SelectRegionEvent extends RegionMenuEvent {
  final String regionName;

  SelectRegionEvent(this.regionName);
}

// region_menu_state.dart
abstract class RegionMenuState {}

class RegionMenuInitialState extends RegionMenuState {}

class RegionMenuLoadingState extends RegionMenuState {}

class RegionMenuLoadedState extends RegionMenuState {
  final RegionMenuData regionMenuData;

  RegionMenuLoadedState(this.regionMenuData);
}

class RegionMenuErrorState extends RegionMenuState {
  final String errorMessage;

  RegionMenuErrorState(this.errorMessage);
}
