import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:post_case_study/features/cashier/home/data/model/item.dart';

class CustomerCard extends StatelessWidget {
  final Item item;
  const CustomerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExtendedImage.network(
              cache: true,
              height: MediaQuery.sizeOf(context).height * 0.1,
              item.imageUrl),
        ],
      ),
    );
  }
}
