import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../services/wilayas_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial()) {
    _checkUserAddress();
  }

  void _checkUserAddress() async {
    final wilayasList = await getWilayas();
    // Example logic to check if an address is already selected
    final bool hasAddress = false; // Replace with actual check
    if (hasAddress) {
      emit(LocationLoaded(
        wilaya: 'Saved Wilaya',
        daira: 'Saved Daira',
        commune: 'Saved Commune',
        address: 'Saved Address',
      ));
    } else {
      emit(LocationLoading(
        wilayasList: wilayasList,
      ));
    }
  }

  void updateWilaya(String wilaya) {
    emit(LocationLoading(
      wilaya: wilaya,
    ));
  }

  void updateDaira(String daira) {
    final currentState = state as LocationLoading;
    emit(LocationLoading(
      wilaya: currentState.wilaya,
      daira: daira,
    ));
  }

  void updateCommune(String commune) {
    final currentState = state as LocationLoading;
    emit(LocationUpdated(
      wilaya: currentState.wilaya!,
      daira: currentState.daira!,
      commune: commune,
    ));
  }

  void updateAddress(String address) {
    final currentState = state as LocationUpdated;
    emit(LocationUpdated(
      wilaya: currentState.wilaya,
      daira: currentState.daira,
      commune: currentState.commune,
      address: address,
    ));
  }

  Future<List<String>> getWilayas() async {
    final wilayasService = WilayasService();
    return await wilayasService.getWilayaNames();
  }

  List<String> getDairas(String? wilaya) {
    // Temporary placeholder; replace with API call to fetch dairas based on selected wilaya
    if (wilaya == 'Wilaya 1') return ['Daira 1-1', 'Daira 1-2'];
    if (wilaya == 'Wilaya 2') return ['Daira 2-1', 'Daira 2-2'];
    return [];
  }

  List<String> getCommunes(String? daira) {
    // Temporary placeholder; replace with API call to fetch communes based on selected daira
    if (daira == 'Daira 1-1') return ['Commune 1-1-1', 'Commune 1-1-2'];
    if (daira == 'Daira 2-1') return ['Commune 2-1-1', 'Commune 2-1-2'];
    return [];
  }

  void saveLocation() {
    if (state is LocationUpdated) {
      final updatedLocation = state as LocationUpdated;
      emit(LocationLoaded(
          wilaya: updatedLocation.wilaya,
          daira: updatedLocation.daira,
          commune: updatedLocation.commune,
          address: updatedLocation.address,
      ));
    }
  }
}
