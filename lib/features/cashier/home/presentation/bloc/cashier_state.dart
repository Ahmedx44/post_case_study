class CashierState {
  final int selectedIndex;

  const CashierState({required this.selectedIndex});

  CashierState copyWith({int? selectedIndex}) {
    return CashierState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
