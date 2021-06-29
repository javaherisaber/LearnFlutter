mixin ValidationMixin {

  String? validateEmail(String? value) {
    // just a simple check to showcase validator
    if (value == null) return null;
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null) return null;
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
