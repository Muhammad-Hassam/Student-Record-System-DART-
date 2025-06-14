import 'dart:io';

class ConsoleUtils {
  static String readString(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync() ?? '';
  }

  static int readInt(String prompt) {
    while (true) {
      try {
        return int.parse(readString(prompt));
      } catch (e) {
        print('Invalid input. Please enter a valid number.');
      }
    }
  }

  static double readDouble(String prompt) {
    while (true) {
      try {
        return double.parse(readString(prompt));
      } catch (e) {
        print('Invalid input. Please enter a valid number.');
      }
    }
  }

  static void clearScreen() {
    print('\x1B[2J\x1B[0;0H');
  }
}
