import '../constant/regex_constant.dart';

class LoginBloc {
  String? emailValidator({String? email}) {
    if (email == null || email.isEmpty) {
      return 'Please Enter Your Email';
    }else if(!RegexConst.emailRegex.hasMatch(email)){
      return 'Invalid Email';
    }
    return null;
  }

  String? passwordValidator({String? password}) {
    if (password == null || password.trim().isEmpty) {
      return 'Password is required';
    }
    return null;
  }


 }
