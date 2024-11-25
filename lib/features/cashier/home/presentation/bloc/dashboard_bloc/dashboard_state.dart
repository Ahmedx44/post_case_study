import 'package:post_case_study/features/cashier/home/data/model/item.dart';

class DashboardState {}

class DashboardStateInitial extends DashboardState {}

class DashboardStateLoading extends DashboardState {}

class DashboardStateLoaded extends DashboardState {
  final List<Item> items;

  DashboardStateLoaded({required this.items});
}

class DashboardStateError extends DashboardState {
  final String error;

  DashboardStateError({required this.error});
}
