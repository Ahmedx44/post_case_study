import 'package:post_case_study/admin/features/item/data/model/item_model.dart';

abstract class ItemState {}

class ItemStateInitial extends ItemState {}

class ItemStateLoaded extends ItemState {
  final List<ItemModel> item;

  ItemStateLoaded({required this.item});
}

class ItemStateLoading extends ItemState {}

class ItemStateError extends ItemState {
  final String errorMessage;

  ItemStateError({required this.errorMessage});
}
