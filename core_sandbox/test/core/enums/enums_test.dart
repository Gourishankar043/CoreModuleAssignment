
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/enums/enums.dart';

void main() {
  group('BaseUrlType', () {
    test('should contain all base URL types', () {
      expect(
        BaseUrlType.values,
        [
          BaseUrlType.defaultService,
          BaseUrlType.microsoftService,
          BaseUrlType.chatbotService,
        ],
      );
    });
  });

  group('UserRole', () {
    test('should contain all user roles', () {
      expect(
        UserRole.values,
        [
          UserRole.accountManager,
          UserRole.areaSalesManager,
          UserRole.unknown,
        ],
      );
    });
  });

  group('BadgeType', () {
    test('newItem should have the correct value and display text', () {
      expect(BadgeType.newItem.value, 'new');
      expect(BadgeType.newItem.displayText, 'New');
    });

    test('update should have the correct value and display text', () {
      expect(BadgeType.update.value, 'update');
      expect(BadgeType.update.displayText, 'Update');
    });

    test('fromString should return the correct enum', () {
      expect(BadgeType.fromString('new'), BadgeType.newItem);
      expect(BadgeType.fromString('update'), BadgeType.update);
    });

    test('fromString should be case-insensitive', () {
      expect(BadgeType.fromString('NEW'), BadgeType.newItem);
      expect(BadgeType.fromString('UPDATE'), BadgeType.update);
    });

    test('fromString should return null for an invalid value', () {
      expect(BadgeType.fromString('invalid'), isNull);
    });
  });
}
