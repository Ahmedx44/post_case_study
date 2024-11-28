import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    try {
      final isDark = json['isDark'] as bool? ?? false;
      return isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      return ThemeMode.light; // Default to light mode on error
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'isDark': state == ThemeMode.dark};
  }
}
