abstract class CartState {}

class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {}

class CartStateError extends CartState {}

class CartStateCartAdded extends CartState {
  final String message;

  CartStateCartAdded({required this.message});
}
