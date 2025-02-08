import 'package:bloc/bloc.dart';
import 'package:rawaaj/constants/price_ranges_consts.dart';
import 'package:equatable/equatable.dart';


part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void changeSize(int newSize) {
    if (newSize >= 0 && newSize <= 5) {
      emit(FilterState(
        size: newSize,
        color: state.color,
        priceRange: state.priceRange,
        sortType: state.sortType,
      ));
    }
  }

  void changeColor(int newColor) {
    if (newColor >= 0 && newColor <= 6) {
      emit(FilterState(
        size: state.size,
        color: newColor,
        priceRange: state.priceRange,
        sortType: state.sortType,
      ));
    }
  }

  void changePriceRange(int lower, int upper) {
    if (lower >= lowerPriceBound && upper <= upperPriceBound && upper > lower) {
      emit(FilterState(
        size: state.size,
        color: state.color,
        priceRange: PriceRange(lower, upper),
        sortType: state.sortType,
      ));
    }
  }

  void changeSortType(int newSortType) {
    if(newSortType >= 1 && newSortType <= 4) {
      emit(FilterState(
      size: state.size,
      color: state.color,
      priceRange: state.priceRange,
      sortType: newSortType,
    ));
    }
  }

  void resetFilters() {
    emit(const FilterState());
  }
}
