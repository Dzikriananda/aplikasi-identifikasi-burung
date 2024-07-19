extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }
  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    return this.length>7;
  }

  bool get isNotNull{
    return this.length!=0;
  }

  bool get isValidPhone{
    return this.length>7;
    // final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    // return phoneRegExp.hasMatch(this);
  }

}