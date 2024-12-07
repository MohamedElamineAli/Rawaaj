import 'package:flutter/material.dart';

class FilterSizeLine extends StatefulWidget {

  FilterSizeLine({Key? key}) : super(key: key);

  @override
  State<FilterSizeLine> createState() => _FilterSizeLineState();
}

class _FilterSizeLineState extends State<FilterSizeLine> {
  int selected = 2;

  @override
  Widget build(BuildContext context) {
    List<String> sizesList = ["XS", "S", "M", "L", "XL", "2XL"];
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: Container(
              width: double.infinity,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFFEEF4FF),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          )),
          Positioned.fill(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < sizesList.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = i;
                      });
                    },
                    child: buildSizeElement(sizesList[i], i)),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget buildSizeElement(String sizeName, int num) {
    return (num == selected)
        ? Container(
            decoration: BoxDecoration(
              color: Color(0xFFE5F1FF),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4), // Shadow position
                ),
              ],
            ),
            width: 38,
            height: 38,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 34,
                height: 34,
                child: Center(
                  child: Text(
                    sizeName,
                    style: TextStyle(fontSize: 16, color: Colors.lightBlue),
                  ),
                ),
              ),
            ))
        : Container(
            width: 38,
            height: 38,
            child: Center(
              child: Text(
                sizeName,
                style: TextStyle(fontSize: 16, color: Color(0xFF8EB6FF)),
              ),
            ),
          );
  }
}
