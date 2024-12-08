import 'package:post_case_study/cashier/feature/home/domain/entity/cart_item_enitity.dart';

abstract class CartState {}

class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {
  final List<CartItemEntity> cartItems;

  CartStateLoaded({required this.cartItems});
}

class CartStateError extends CartState {}

class CartStateCartAdded extends CartState {
  final String message;

  CartStateCartAdded({required this.message});
}
