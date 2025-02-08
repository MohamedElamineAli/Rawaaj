import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/constants/price_ranges_consts.dart';
import '../cubit/filter_cubit.dart';

class RangeSliderWidget extends StatelessWidget {
  const RangeSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        double lowerValue = state.priceRange.lower.toDouble();
        double upperValue = state.priceRange.upper.toDouble();

        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FlutterSlider(
            values: [lowerValue, upperValue],
            rangeSlider: true,
            max: upperPriceBound.toDouble(),
            min: lowerPriceBound.toDouble(),
            step: const FlutterSliderStep(step: 10),
            onDragging: (handlerIndex, newLowerValue, newUpperValue) {
              context.read<FilterCubit>().changePriceRange(
                newLowerValue.toInt(),
                newUpperValue.toInt(),
              );
            },
            handler: _buildFlutterSliderHandler(),
            rightHandler: _buildFlutterSliderHandler(),
          ),
        );
      },
    );
  }

  FlutterSliderHandler _buildFlutterSliderHandler() {
    return FlutterSliderHandler(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color(0xFFE5EBFC),
        ),
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
