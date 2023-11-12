import '../constant/regex_constant.dart';

class SignUpBloc{
  String? nameValidator({String? name}) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  String? emailValidator({String?email}){

    if(email == null || email.trim().isEmpty){
      return 'Email is required';
    }else if(!RegexConst.emailRegex.hasMatch(email)){
      return 'Invalid Email';
    }
    return  null;
  }

  String? mobileValidator({String?mobile}){
    if(mobile == null || mobile.trim().isEmpty){
      return 'Please enter your mobile number';
    }
    return  null;
  }

  String? passwordValidator({String?password}){
    if(password == null || password.trim().isEmpty){
      return 'Please enter your Password';
    }
    return  null;
  }
  String? confirmPassword({String?confirm,String?password}){
    if(confirm == null || confirm.trim().isEmpty){
      return 'Please Confirm Your Password';
    }else if(confirm != password){
      return 'Password do not match';
    }
    return  null;
  }
}
