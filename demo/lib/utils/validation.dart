class Validation{

  /// validation for mobile
  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (value.length < 10) {
      return "Invalid Mobile Number";
    }
    return null;
  }

  static String? validateAlphanumeric(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } 
    else if(value.contains(" ")){
      return "space not allowed in username";
    }
    else if(!RegExp(r"[a-zA-Z\d]+|\s").hasMatch(value)) {
      return "Invalid user name";
    }
    return null;
  }

  /// validation
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Required";
    }
    return null;
  }

  /// validation for email
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (!RegExp(
        r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) {
      return "Invalid email address";
    }
    return null;
  }

  /// validation for password
  static String? validatePass(String? value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (value.length < 6) {
      return "Should at least 6 characters";
    }
    return null;
  }
}
