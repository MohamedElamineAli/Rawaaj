import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/shop_cubit.dart';

class StatsSection extends StatelessWidget {
  final int productsNum;
  final int followersNum;
  final bool isFollowed;
  final int shopId;

  const StatsSection({
    super.key,
    required this.productsNum,
    required this.followersNum,
    required this.isFollowed,
    required this.shopId,
  });

  Widget _buildStatColumn(int value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _onUnfollowPressed(BuildContext context) {
    if (isFollowed) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Unfollow Shop"),
            content: const Text("Are you sure you want to unfollow this shop?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<ShopCubit>().toggleFollow(shopId);
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    } else {
      context.read<ShopCubit>().toggleFollow(shopId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildStatColumn(productsNum, 'Products'),
          const SizedBox(width: 48),
          _buildStatColumn(followersNum, 'Followers'),
          const Spacer(),
          OutlinedButton(
            onPressed: () => _onUnfollowPressed(context),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide(
                color: isFollowed ? Colors.green : const Color(0xFF004BFE),
                width: 1.5,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 12,
              ),
            ),
            child: Text(
              isFollowed ? 'Followed' : '+ Follow',
              style: TextStyle(
                color: isFollowed ? Colors.green : const Color(0xFF004BFE),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}