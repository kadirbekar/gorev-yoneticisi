/*If we have any control for form validation it should be written here*/

class RegexKontrol {
  static String valueLenghtControl(String value) {
    if (value.isEmpty) {
      return "Please write something.";
    } else {
      return null;
    }
  }
}
