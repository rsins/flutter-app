class MenuConstants {
  static const String menuAbout = 'About';

  static final List<String> menuItems = List.unmodifiable([menuAbout]);
}

class ButtonConstants {
  static const String clear = 'C';
  static const String startBracket = '(';
  static const String closeBracket = ')';
  static const String delete = 'DEL';

  static const String one = '1';
  static const String two = '2';
  static const String three = '3';
  static const String four = '4';
  static const String five = '5';
  static const String six = '6';
  static const String seven = '7';
  static const String eight = '8';
  static const String nine = '9';
  static const String zero = '0';

  static const String divide = '/';
  static const String multiply = 'x';
  static const String minus = '-';
  static const String plus = '+';
  static const String equal = '=';
  static const String decimal = '.';

  static final List<String> buttonItems = [
    clear,
    startBracket,
    closeBracket,
    delete,
    seven,
    eight,
    nine,
    divide,
    four,
    five,
    six,
    multiply,
    one,
    two,
    three,
    minus,
    zero,
    decimal,
    equal,
    plus,
  ];

  static final List<String> buttonOperatorItems = [
    plus,
    minus,
    multiply,
    divide,
    equal
  ];
}
