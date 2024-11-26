class AdminState {
  final int selectedIndex;

  const AdminState({required this.selectedIndex});

  AdminState copyWith({int? selectedIndex}) {
    return AdminState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
