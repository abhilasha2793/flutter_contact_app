
String? validatorPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter mobile number';
  }
  final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validateLandlineNumber(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter valid landline number';
  }
  return null;
}