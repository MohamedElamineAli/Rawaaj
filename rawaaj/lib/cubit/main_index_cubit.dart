import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_index_state.dart';

class MainIndexCubit extends Cubit<MainIndexState> {
  MainIndexCubit() : super(MainIndexState(index: 0));

  void changeMainIndex(int newIndex) {
    emit(MainIndexState(index: newIndex));
  }
}
