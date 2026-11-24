import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/theme_cubit.dart';
import 'pages/profil_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Palet warna konsisten: primary, secondary, background.
  static const _primary = Color(0xFF1E5AA8);
  static const _secondary = Color(0xFF00A896);

  ThemeData _buildTheme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      secondary: _secondary,
      brightness: brightness,
    );
    final base = ThemeData(colorScheme: scheme, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: brightness == Brightness.light
          ? const Color(0xFFF4F7FB)
          : const Color(0xFF10151C),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: scheme.onPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          title: 'Profil Mahasiswa',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          themeMode: mode,
          home: const ProfilPage(),
        ),
      ),
    );
  }
}
