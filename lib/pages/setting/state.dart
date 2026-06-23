class SettingState {
  const SettingState({
    this.language = false,
  });

  final bool language;

  SettingState copyWith({bool? language}) {
    return SettingState(
      language: language ?? this.language,
    );
  }
}
