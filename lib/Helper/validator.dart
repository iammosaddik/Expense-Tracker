class CustomValidator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }
    return null;
  }

  static String? validateLastName({required String? lastName}) {
    if (lastName == null) {
      return null;
    }
    if (lastName.isEmpty) {
      return 'Last Name can\'t be empty';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validatePhoneNumber({required String? phoneNumber}) {
    if (phoneNumber == null) {
      return null;
    }
    if (phoneNumber.isEmpty) {
      return 'Phone Number can\'t be empty';
    }
    return null;
  }

  static String? validateInPassword({
    String? password,
  }) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }

  static String? validateUpPassword({
    String? password,
  }) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }
    return null;
  }

  static String? validateRePassword({String? rePassword}) {
    if (rePassword == null) {
      return null;
    }
    if (rePassword.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }
}
