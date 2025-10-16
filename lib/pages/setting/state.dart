class SettingState {
  const SettingState({
    this.isOpen = true,
    this.language = false,
  });

  final bool isOpen;
  final bool language;

  SettingState copyWith({bool? isOpen, bool? language}) {
    return SettingState(
      isOpen: isOpen ?? this.isOpen,
      language: language ?? this.language,
    );
  }
}
