abstract class InvoiceState {}

class InvoiceStateInital extends InvoiceState {}

class InvoiceStateLoading extends InvoiceState {}

class InvoiceStateLoaded extends InvoiceState {
  final invoice;

  InvoiceStateLoaded({required this.invoice});
}

class InvoiceStateError extends InvoiceState {
  final String error;

  InvoiceStateError({required this.error});
}
