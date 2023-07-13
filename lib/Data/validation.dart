class Validation{

  static bool validateEmail(String value){
    String emailExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(emailExp);
    return regExp.hasMatch(value);
  }

  static bool validatePassword(String value){
    String passwordExp = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(passwordExp);
    return regExp.hasMatch(value);
  }

  static bool validatePhone(String value){
    String phoneExp = r"^[0-9]{10}$";
    RegExp regExp = RegExp(phoneExp);
    return regExp.hasMatch(value);
  }

  static validateOtp(String pin){
    if(pin.isEmpty){
      return 'please enter some pin';
    }
  }
}