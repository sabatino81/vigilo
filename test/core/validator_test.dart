import 'package:vigilo/core/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormValidator', () {
    test('requiredValue returns message for null/empty', () {
      expect(FormValidator.requiredValue(null), isNotNull);
      expect(FormValidator.requiredValue(''), isNotNull);
      expect(FormValidator.requiredValue('  '), isNotNull);
      expect(FormValidator.requiredValue('ok'), isNull);
    });

    test('emailValue validates emails', () {
      expect(FormValidator.emailValue(''), isNotNull);
      expect(FormValidator.emailValue('not-an-email'), isNotNull);
      expect(FormValidator.emailValue('test@example.com'), isNull);
    });

    test('minLengthValue and maxLengthValue', () {
      expect(FormValidator.minLengthValue('abc', 5), isNotNull);
      expect(FormValidator.minLengthValue('abcdef', 5), isNull);
      expect(FormValidator.maxLengthValue('abcd', 3), isNotNull);
      expect(FormValidator.maxLengthValue('ab', 3), isNull);
    });

    test('passwordValue enforces rules', () {
      expect(FormValidator.passwordValue('short'), isNotNull);
      expect(
        FormValidator.passwordValue('longenough'),
        isNotNull,
      ); // needs upper/digit
      expect(FormValidator.passwordValue('GoodPass1'), isNull);
    });

    test('matchValue compares strings', () {
      expect(FormValidator.matchValue('a', 'b'), isNotNull);
      expect(FormValidator.matchValue('a', 'a'), isNull);
    });

    test('numericRangeValue parses and enforces range', () {
      expect(FormValidator.numericRangeValue('abc', 1, 5), isNotNull);
      expect(FormValidator.numericRangeValue('3', 1, 5), isNull);
      expect(FormValidator.numericRangeValue('6', 1, 5), isNotNull);
    });
  });
}
