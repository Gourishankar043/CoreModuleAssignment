enum BaseUrlType {
  defaultService,
  microsoftService,
  chatbotService,
}
enum UserRole {
  accountManager,
  areaSalesManager,
  unknown,
}
enum BadgeType {
  newItem('new', 'New'),
  update('update', 'Update');

  const BadgeType(this.value, this.displayText);

  final String value;
  final String displayText;

  static BadgeType? fromString(String value) {
    for (final type in BadgeType.values) {
      if (type.value.toLowerCase() == value.toLowerCase()) {
        return type;
      }
    }
    return null;
  }
}