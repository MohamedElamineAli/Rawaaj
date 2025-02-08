import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/filter_cubit.dart';

class SortButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        int selectedValue = state.sortType;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CustomRadioButton(
                  context: context,
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    if (value != null) {
                      context.read<FilterCubit>().changeSortType(value);
                    }
                  },
                  label: 'Popular',
                ),
                CustomRadioButton(
                  context: context,
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    if (value != null) {
                      context.read<FilterCubit>().changeSortType(value);
                    }
                  },
                  label: 'Price High to Low',
                ),
              ],
            ),
            Column(
              children: [
                CustomRadioButton(
                  context: context,
                  value: 3,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    if (value != null) {
                      context.read<FilterCubit>().changeSortType(value);
                    }
                  },
                  label: 'Newest',
                ),
                CustomRadioButton(
                  context: context,
                  value: 4,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    if (value != null) {
                      context.read<FilterCubit>().changeSortType(value);
                    }
                  },
                  label: 'Price Low to High',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final String label;
  final BuildContext context;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: groupValue == value
              ? const Color(0xFFE1EBFF)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: groupValue == value ? Colors.blue : Colors.black,
              ),
            ),
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: groupValue == value ? Colors.blue : Colors.transparent,
                border: Border.all(
                  color: groupValue == value ? Colors.white : Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: groupValue == value
                  ? const Icon(Icons.check, size: 16.0, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
