/// Centralized form validation helpers for the app.
///
/// Each method returns a validator suitable for `TextFormField.validator`
/// (i.e. `String? Function(String?)`). Functions also expose lower-level
/// helpers that operate on a raw `String?` value.
class FormValidator {
  FormValidator._();

  // Low-level helpers -----------------------------------------------------
  static String? requiredValue(String? value, {String? message}) {
    final m = message ?? 'This field is required';
    if (value == null) return m;
    if (value.trim().isEmpty) return m;
    return null;
  }

  static String? emailValue(String? value, {String? message}) {
    final m = message ?? 'Enter a valid email address';
    if (value == null || value.trim().isEmpty) return m;
    final email = value.trim();
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email) ? null : m;
  }

  static String? minLengthValue(String? value, int min, {String? message}) {
    final m = message ?? 'Minimum length is $min characters';
    if (value == null) return m;
    return value.trim().length >= min ? null : m;
  }

  static String? maxLengthValue(String? value, int max, {String? message}) {
    final m = message ?? 'Maximum length is $max characters';
    if (value == null) return null; // nothing to check
    return value.trim().length <= max ? null : m;
  }

  static String? passwordValue(
    String? value, {
    int minLength = 8,
    bool requireUpper = true,
    bool requireLower = true,
    bool requireDigit = true,
    String? message,
  }) {
    const defaultMsg = 'Password does not meet complexity requirements';
    final m = message ?? defaultMsg;
    if (value == null || value.isEmpty) return m;
    final v = value.trim();
    if (v.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    if (requireUpper && !RegExp('[A-Z]').hasMatch(v)) return m;
    if (requireLower && !RegExp('[a-z]').hasMatch(v)) return m;
    if (requireDigit && !RegExp(r'\d').hasMatch(v)) return m;
    return null;
  }

  static String? matchValue(String? value, String? other, {String? message}) {
    final m = message ?? 'Values do not match';
    if (value == null && other == null) return null;
    if (value == null || other == null) return m;
    return value == other ? null : m;
  }

  static String? numericRangeValue(
    String? value,
    num min,
    num max, {
    String? message,
  }) {
    final m = message ?? 'Value must be between $min and $max';
    if (value == null || value.trim().isEmpty) return m;
    final parsed = num.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    return (parsed >= min && parsed <= max) ? null : m;
  }

  // Validator factory helpers --------------------------------------------
  static String? Function(String?) required({String? message}) {
    return (v) => requiredValue(v, message: message);
  }

  static String? Function(String?) email({String? message}) {
    return (v) => emailValue(v, message: message);
  }

  static String? Function(String?) minLength(int min, {String? message}) {
    return (v) => minLengthValue(v, min, message: message);
  }

  static String? Function(String?) maxLength(int max, {String? message}) {
    return (v) => maxLengthValue(v, max, message: message);
  }

  static String? Function(String?) password({
    int minLength = 8,
    bool requireUpper = true,
    bool requireLower = true,
    bool requireDigit = true,
    String? message,
  }) {
    return (v) => passwordValue(
      v,
      minLength: minLength,
      requireUpper: requireUpper,
      requireLower: requireLower,
      requireDigit: requireDigit,
      message: message,
    );
  }

  /// Returns a validator that checks the current value equals [other].
  /// Note: you may need to close over the other field's controller/text.
  static String? Function(String?) match(String? other, {String? message}) {
    return (v) => matchValue(v, other, message: message);
  }

  static String? Function(String?) numericRange(
    num min,
    num max, {
    String? message,
  }) {
    return (v) => numericRangeValue(v, min, max, message: message);
  }
}
