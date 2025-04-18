part of 'theme_cubit.dart';

abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeLoaded({required this.themeData, required this.isDarkMode});
}
