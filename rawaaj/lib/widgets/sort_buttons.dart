import 'package:flutter/material.dart';

class SortButtons extends StatefulWidget {
  @override
  _SortButtonsState createState() => _SortButtonsState();
}

class _SortButtonsState extends State<SortButtons> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Spread the columns evenly
      children: [
        Column(
          children: [
            CustomRadioButton(
              context: context,
              value: 1,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
              label: 'Popular',
            ),
            CustomRadioButton(
              context: context,
              value: 2,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                setState(() {
                  _selectedValue = value!;
                });
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
              groupValue: _selectedValue,
              onChanged: (int? value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
              label: 'Newest',
            ),
            CustomRadioButton(
              context: context,
              value: 4,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                setState(() {
                  _selectedValue = value!;
                });
              },
              label: 'Price Low to High',
            ),
          ],
        ),
      ],
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
        width: MediaQuery.of(context).size.width/2 - 30,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: groupValue == value
              ? Color(0xFFE1EBFF)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.only(right: 4, top: 4, bottom: 4, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(width: 0,),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: groupValue == value
                    ? Colors.blue
                    : Colors.black
              ),
            ),
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: groupValue == value ? Colors.blue : Colors.transparent,
                border: Border.all(
                  color:
                      groupValue == value ? Colors.white : Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: groupValue == value
                  ? Icon(Icons.check, size: 16.0, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
