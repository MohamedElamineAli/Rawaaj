part of 'filter_cubit.dart';

const defaultPriceRange = PriceRange(lowerPriceBound, upperPriceBound);

class FilterState extends Equatable {
  final int size;
  final int color;
  final PriceRange priceRange;
  final int sortType;

  const FilterState({
    this.size = 2,
    this.color = 0,
    this.priceRange = defaultPriceRange,
    this.sortType = 1,
  });

  @override
  List<Object?> get props => [size, color, priceRange, sortType];
}

class PriceRange extends Equatable {
  final int lower;
  final int upper;

  const PriceRange(this.lower, this.upper);

  @override
  List<Object?> get props => [lower, upper];
}
