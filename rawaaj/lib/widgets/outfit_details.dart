import 'package:flutter/material.dart';

class OutfitDetails extends StatefulWidget {
  final String img;
  final int price;
  final int likesNum;
  final bool isLiked;
  final String details;

  const OutfitDetails(
      {super.key,
      required this.img,
      required this.price,
      required this.isLiked,
      required this.details,
      required this.likesNum});

  @override
  State<OutfitDetails> createState() => _OutfitDetailsState();
}

class _OutfitDetailsState extends State<OutfitDetails> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              widget.img,
              width: 300,
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.price} DZD",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    "${widget.likesNum}K",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 28,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          child: Text(
            widget.details,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          width: double.infinity,
        )
      ],
    );
  }
}
