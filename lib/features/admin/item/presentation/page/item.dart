import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:post_case_study/features/admin/item/data/model/item_model.dart';
import 'package:post_case_study/features/admin/item/presentation/bloc/item_cubit.dart';
import 'package:post_case_study/features/admin/item/presentation/bloc/item_state.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit()..getAllItem(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            if (state is ItemStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemStateLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: state.item.length,
                  itemBuilder: (context, index) {
                    final item = state.item[index];
                    return _buildItemCard(item);
                  },
                ),
              );
            } else if (state is ItemStateError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(
              child: Text('No items available'),
            );
          },
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    // Adjust the number of columns based on screen width
    if (MediaQuery.of(context).size.width < 600) {
      return 2; // Mobile
    } else if (MediaQuery.of(context).size.width < 1200) {
      return 3; // Tablet
    } else {
      return 4; // Desktop
    }
  }

  Widget _buildItemCard(ItemModel item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Widget
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: ExtendedImage.network(
                item.imageUrl,
                fit: BoxFit.fill,
                cache: true,
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.error, color: Colors.red),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          // Item Details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.category,
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
