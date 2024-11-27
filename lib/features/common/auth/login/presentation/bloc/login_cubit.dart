import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginStateIntital());

  void login(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (username.isEmpty || password.isEmpty) {
      emit(LoginStateError());
      return;
    }

    emit(LoginStateLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (username == "admin" && password == "password") {
        emit(LoginStateAdmin());
        await prefs.setBool('auth_user', true);
      } else if (username == "cashier" && password == "password") {
        emit(LoginStateCashier());
      } else {}
    } catch (e) {
      emit(LoginStateError());
      emit(LoginStateIntital());
    }
  }
}
