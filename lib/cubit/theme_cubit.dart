import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit sederhana untuk mengelola mode tema (terang/gelap).
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggle() =>
      emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
}
