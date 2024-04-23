import 'package:email_validator/email_validator.dart';
import 'package:smart_home_fe/services/user_service.dart';

String? validateEmpty(String? value) {
  if(value == null || value.isEmpty) {
    return "Cannot be empty";
  }
  return null;
}

String? validateEmail(String? value) {
  return EmailValidator.validate(value ?? "") ? null : "Invalid email";
}

String? validateSelectionItem(dynamic value) {
  if(value == null) {
    return "Please select an option";
  }
  return null;
}

String? validateUsername (String? value) {
  if(value == null || value.isEmpty) {
    return "Cannot be empty";
  } else if (value.length < 6 ) {
    return "Username must be at least 6 characters long";
  } else {
    bool exist = false;
    UserService().getAllUsername()
    .then((usernames) => usernames.contains(value))
    .then((value) => exist = value);
    return exist ? "Username exist" : null;
  }
}