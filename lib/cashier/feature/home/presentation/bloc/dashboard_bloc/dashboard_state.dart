class DashboardState {}

class DashboardStateInitial extends DashboardState {}

class DashboardStateLoading extends DashboardState {}

class DashboardStateLoaded extends DashboardState {
  final List items;

  DashboardStateLoaded({required this.items});
}

class DashboardStateError extends DashboardState {
  final String error;

  DashboardStateError({required this.error});
}
