import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/cashier/home/presentation/bloc/cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit() : super(const CashierState(selectedIndex: 0));

  final PageController pageController = PageController();

  void onItemTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
    pageController.jumpToPage(index);
  }
}
