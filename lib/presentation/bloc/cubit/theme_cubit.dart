import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';
import 'package:tsalul_url_player/domain/repositories/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository themeRepository;

  ThemeCubit(this.themeRepository) : super(ThemeInitial()) {
    _loadInitialTheme();
  }

  Future<void> _loadInitialTheme() async {
    final isDark = await themeRepository.isDarkMode();
    emit(
      ThemeLoaded(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDarkMode: isDark,
      ),
    );
  }

  Future<void> toggleTheme(bool isDark) async {
    await themeRepository.setDarkMode(isDark);
    emit(
      ThemeLoaded(
        themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        isDarkMode: isDark,
      ),
    );
  }
}
