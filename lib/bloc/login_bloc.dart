class LoginBloc {
  String? emailValidator({String? emailValidator}) {
    if (emailValidator == null || emailValidator.isEmpty) {
      return 'Please Enter Your Email';
    }
    return null;
  }

  String? passwordValidator({String? passwordValidator}) {
    if (passwordValidator == null || passwordValidator.trim().isEmpty) {
      return 'Password is required';
    }
    return null;
  }


 }
