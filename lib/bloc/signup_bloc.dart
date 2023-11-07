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
  String? confirmPassword({String?confirm}){
    if(confirm == null || confirm.trim().isEmpty){
      return 'Please Confirm Your Password';
    }
    return  null;
  }
}



