import 'package:get/get.dart';

/// REGULAR EXPRESSION
class RegularExpression {
  /// TextField Enter Pattern Expression
  static String passwordPattern = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String alphabetSpacePattern = r"[a-zA-Z ]";
  static String alphabetDigitsPattern = r"[a-zA-Z0-9 ]";

  /// Validation Expression Pattern
  static String emailValidationPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String nameKeyboardPattern = "[A-z]";
  static String allKeyboardPattern = "[a-zA-Z0-9#!_@\$%^&*-.()&'\"?!;:<> ]";
  static String searchKeyboardPattern = "[A-z-/]";
  static String contactKeyboardPattern = "[0-9]";
  static String fullNameKeyboardPattern = "[A-z ]";
  static String emailKeyboardPattern = "[0-9A-z@.]";

  static String noSpaceAllowPattern = "[ ]";
  static String onlyFirstSpaceNoAllowPattern = "^[ ]";
  // static String onlyFirstSpaceNoAllowPattern = "^[ /]";
}

/// ------------------------------------------------------------------- ///
/// VALIDATION MESSAGE WITH
// class ValidationMsg {
//   static String isRequired = "Filled is required";
//   static String passwordLength = 'Password must be more than 4 char';
//   static String modelNumberLength = 'Model number maximum 12 char';
//   static String voucherCodeLength = 'Voucher code maximum 8 char';
//   static String pinLength = 'PIN must be 6 digit';
//   static String pleaseEnterValidEmail = "Enter valid email";
//   static String enterValidName = "Enter valid Name";
//   static String enterValidDate = "enter valid date";
//   static String passwordDoesNotMatch = 'Password does\'t match';
//   static String numberIsInvalid = 'Card is invalid';
//   static String cvvInvalid = 'CVV is invalid';
//   static String cardExpired = 'Card has expired';
//   static String invalidInput = 'invalid input';
// }

class ValidationMsg {
  static String isRequired = "Field is required";
  // static String passwordLength = 'passwordLength';
  // static String modelNumberLength = 'modelNumberLength';
  // static String voucherCodeLength = 'voucherCodeLength';
  // static String pinLength = 'pinLength';
  // static String maxClientLength = 'maxClientLength12';
  // static String pleaseEnterValidEmail = "pleaseEnterValidEmail";
  // static String enterValidName = "enterValidName";
  // static String enterValidDate = "enterValidDate";
  // static String passwordDoesNotMatch = 'passwordDoesNotMatch';
}

emptyValidation(value) {
  if (value.toString().isEmpty) {
    return ValidationMsg.isRequired.tr;
  }
  return null;
}

userValidation(value) {
  if (value.toString().isEmpty) {
    return ValidationMsg.isRequired.tr;
  }
  if (!RegExp(RegularExpression.alphabetSpacePattern).hasMatch(value!)) {
    return "Enter valid name";
  }
  return null;
}

mobileValidation(value) {
  if (value.toString().isEmpty) {
    return ValidationMsg.isRequired.tr;
  }
  if (value.toString().length < 10) {
    return "Mobile number must be 10 char";
  }
  return null;
}

passwordValidation(value) {
  if (value.toString().isEmpty) {
    return ValidationMsg.isRequired.tr;
  } else if (value.toString().length < 6) {
    return "password must be more then 6 char";
  }
  return null;
}
