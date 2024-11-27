import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(const AdminState(selectedIndex: 0));

  final PageController pageController = PageController();

  void onItemTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
    pageController.jumpToPage(index);
  }
}
