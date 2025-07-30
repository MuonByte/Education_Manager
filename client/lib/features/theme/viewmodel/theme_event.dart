import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}
class ToggleThemeEvent extends ThemeEvent {
  final bool isDarkMode;
  const ToggleThemeEvent(this.isDarkMode);
  @override
  List<Object> get props => [isDarkMode];
}