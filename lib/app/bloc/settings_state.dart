part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDark;

  SettingsLoaded(this.isDark);
}
