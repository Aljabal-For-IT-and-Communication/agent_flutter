abstract class SettingEvent {
  const SettingEvent();
}

class IsOpenChanged extends SettingEvent {
  const IsOpenChanged(this.isOpen);

  final bool isOpen;
}

class IsLanguageChanged extends SettingEvent {
  const IsLanguageChanged(this.language);

  final bool language;
}