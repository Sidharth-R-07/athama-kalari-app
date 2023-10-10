//YOUTUBE LINK VALIDATION
String? validateYouTubeLink(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a YouTube link';
  }

  // Regular expression to match YouTube video URLs
  RegExp regExp =
      RegExp(r"^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$");

  if (!regExp.hasMatch(value)) {
    return 'Please enter a valid YouTube link';
  }

  return null;
}

//AMOUNT VALIDATION

String? validationAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a number';
  }

  // Regular expression to match numeric input
  RegExp numericRegex = RegExp(r'^[0-9]+$');

  if (!numericRegex.hasMatch(value)) {
    return 'Please enter only numeric characters';
  }

  return null;
}
//TERMS AND CONDITION VALIDATION

String? validateTermsAndCondition(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Terms & Conditions';
  }

  if (value.length < 10) {
    return 'Terms & Conditions must be at least 10 characters';
  }

  return null;
}

//DESCRIPTION VALIDATION

String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Description';
  }

  if (value.length < 10) {
    return 'Description be at least 10 characters';
  }

  return null;
}

//TITLE VALIDATION

String? validateTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter tiltle';
  }

  if (value.length < 3) {
    return 'title must be at least 3 characters';
  }
  return null;
}

//NAME VALIDATION
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter name';
  }

  if (value.length < 2) {
    return 'name must be at least 3 characters';
  }
  return null;
}

//BLOOD GROUP VALIDATION
String? validateBloodGroup(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter blood group';
  }

  return null;
}

//VALIDATE PHONE NUMBER
String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone number';
  }
  RegExp numericRegex = RegExp(r'^[0-9]+$');

  if (!numericRegex.hasMatch(value)) {
    return 'Please enter only numeric characters';
  }
  if (value.length != 10) {
    return 'Phone number must be 10 characters';
  }
  return null;
}
//ADDRESS VALIDATION

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Address';
  }

  if (value.length < 10) {
    return 'Please enter a valid Address';
  }

  return null;
}
