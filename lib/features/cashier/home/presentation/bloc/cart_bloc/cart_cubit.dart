import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/cashier/home/domain/usecase/add_to_cart.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cart_bloc/cart_state.dart';
import 'package:post_case_study/locator.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateError());

  addToCart(String name, double price, String imageUrl, String quantity) async {
    emit(CartStateLoading());
    final result =
        await locator<AddToCartUseCase>().call(name, price, imageUrl, quantity);

    result.fold((error) {
      emit(CartStateError());
    }, (succes) {
      emit(CartStateCartAdded(message: succes));
    });
  }
}
