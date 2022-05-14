/// Convert a number to string. Prepend "0",
/// if non-negative integer [number] is below 10.
String _prependZero (int number) {
  if (number < 10 && number >= 0){
    return "0$number";
  }else{
    return number.toString();
  }
}

/// Formats [dateTime] into "yyyy-MM-dd" string
String getISODateString(DateTime dateTime){
  return "${dateTime.year.toString()}-"
      "${_prependZero(dateTime.month)}-"
      "${_prependZero(dateTime.day)}";
}