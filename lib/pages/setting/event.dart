abstract class SettingEvent {
  const SettingEvent();
}

class IsLanguageChanged extends SettingEvent {
  const IsLanguageChanged(this.language);

  final bool language;
}
