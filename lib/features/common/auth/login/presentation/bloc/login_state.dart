import 'package:flutter/material.dart';

abstract class LoginState {}

class LoginStateIntital extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {}

class LoginStateError extends LoginState {}

class LoginStateAdmin extends LoginState {}

class LoginStateCashier extends LoginState {}
