import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/pengaturan_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(PengaturanHelper.muatTema()
      ? ThemeMode.dark : ThemeMode.light);

  Future<void> setGelap(bool gelap) async {
    await PengaturanHelper.simpanTema(gelap);
    if (!isClosed) emit(gelap ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggle() => setGelap(state != ThemeMode.dark);
Future<void> reset() async {
    await PengaturanHelper.reset();
    if (!isClosed) emit(ThemeMode.light);
  }
}
