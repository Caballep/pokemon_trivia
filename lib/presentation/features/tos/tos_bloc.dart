import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/is_tos_accepted_uc.dart';
import 'package:pokemon_trivia/domain/use_case/pokemon/save_tos_acceptance_device_data_uc.dart';

class TosCubit extends Cubit<TosState> {
  final IsTosAcceptedUC _isTosAcceptedUC;
  final SaveTosAcceptanceDeviceDataUC _saveTosAcceptanceDeviceDataUC;

  TosCubit(
      {required IsTosAcceptedUC isTosAcceptedUC,
      required SaveTosAcceptanceDeviceDataUC saveTosAcceptanceDeviceDataUC})
      : _isTosAcceptedUC = isTosAcceptedUC,
        _saveTosAcceptanceDeviceDataUC = saveTosAcceptanceDeviceDataUC,
        super(TosInitialState());

  Future<void> verifyIsTosAccepted() async {
    final isTosAcceptedResult = await _isTosAcceptedUC.invoke();
    if (isTosAcceptedResult.isSuccess) {
      final isTosAccepted = isTosAcceptedResult.data;
      if (isTosAccepted == true) {
        emit(TosAlreadyAcceptedState());
      } else {
        emit(TosNotAcceptedState());
      }
    } else {
      emit(TosErrorState());
    }
  }

  Future<void> saveTosAcceptedDeviceData() async {
    emit(TosAcceptingInProcessState());
    final saveTosAcceptanceDeviceDataResult =
        await _saveTosAcceptanceDeviceDataUC.invoke();
    if (saveTosAcceptanceDeviceDataResult.isSuccess) {
      emit(TosAcceptedState());
    } else {
      emit(TosErrorState());
    }
  }
}

abstract class TosState {}

class TosInitialState extends TosState {}

class TosNotAcceptedState extends TosState {}

class TosAlreadyAcceptedState extends TosState {}

class TosAcceptingInProcessState extends TosState {}

class TosAcceptedState extends TosState {}

class TosErrorState extends TosState {}
