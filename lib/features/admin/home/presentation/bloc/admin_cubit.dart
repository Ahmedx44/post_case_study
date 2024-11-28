import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:post_case_study/features/admin/home/presentation/bloc/admin_state.dart';
import 'package:post_case_study/features/cashier/home/data/model/invoice.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(const AdminState(selectedIndex: 0));
  int totalrevenue = 0;
  int total_transaction = 0;
  int total_item = 0;

  final PageController pageController = PageController();

  void onItemTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
    pageController.jumpToPage(index);
  }

  Future<void> getValues() async {
    final invoiceBox = Hive.box<Invoice>('invoices');

    total_transaction = invoiceBox.values.length;
    totalrevenue = invoiceBox.values
        .fold(0, (sum, invoice) => sum + invoice.totalPrice.toInt());
    total_item =
        invoiceBox.values.fold(0, (sum, invoice) => sum + invoice.totalItems);
  }
}
