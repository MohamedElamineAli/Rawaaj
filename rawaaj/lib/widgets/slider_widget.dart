import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SliderWidget extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final ValueChanged<List<double>> onSubmit;

  const SliderWidget({Key? key, required this.minValue, required this.maxValue, required this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        RangeSliderWidget(lowerValue: minValue, upperValue: maxValue, onSubmit: onSubmit,);
  }
}

class RangeSliderWidget extends StatefulWidget {
  final double lowerValue;
  final double upperValue;
  final ValueChanged<List<double>> onSubmit;

  const RangeSliderWidget(
      {Key? key, required this.lowerValue, required this.upperValue, required this.onSubmit})
      : super(key: key);

  @override
  _RangeSliderWidgetState createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  late double _lowerValue;
  late double _upperValue;

  @override
  void initState() {
    super.initState();
    _lowerValue = widget.lowerValue;
    _upperValue = widget.upperValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FlutterSlider(
        values: [_lowerValue, _upperValue],
        rangeSlider: true,
        max: 15000,
        min: 1000,
        step: FlutterSliderStep(step: 10),
        onDragging: (handlerIndex, lowerValue, upperValue) {
          setState(() {
            _lowerValue = lowerValue;
            _upperValue = upperValue;
          });
          widget.onSubmit([_lowerValue, _upperValue]);
        },
        handler: buildFlutterSliderHandler(),
        rightHandler: buildFlutterSliderHandler(),
      ),
    );
  }

  FlutterSliderHandler buildFlutterSliderHandler() {
    return FlutterSliderHandler(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Color(0xFFE1EBFF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      );
  }
}
