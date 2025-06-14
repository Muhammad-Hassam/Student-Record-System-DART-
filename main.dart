import "./lib/services/auth_service.dart";
import './lib/services/school_record_service.dart';
import './lib/utils/console_utils.dart';

void main() {
  final authService = AuthService();
  final recordService = SchoolRecordService();

  bool authenticated = false;
  while (!authenticated) {
    ConsoleUtils.clearScreen();
    print('School Record Management System');
    print('=' * 30);
    print('1. Login');
    print('2. Sign Up');
    print('3. Exit');

    final choice = ConsoleUtils.readString('Enter your choice: ');

    switch (choice) {
      case '1':
        authenticated = authService.login();
        break;
      case '2':
        authService.signUp();
        break;
      case '3':
        print('Exiting system. Goodbye!');
        return;
      default:
        print('Invalid choice. Please try again.');
    }

    if (!authenticated) {
      ConsoleUtils.readString('\nPress enter to continue...');
    }
  }

  // Main application loop
  while (authService.isLoggedIn) {
    ConsoleUtils.clearScreen();
    print('School Record Management System');
    print('=' * 30);
    print('Logged in as: ${authService.currentUser!.username}');
    if (authService.isAdmin) print('(Admin privileges)');
    print('\nMain Menu:');
    print('1. Add Student');
    print('2. View All Students');
    print('3. View Student by ID');
    print('4. Update Student');
    print('5. Delete Student');
    print('6. Search Students by Name');
    print('7. View Class Performance');
    print('8. Logout');

    final choice = ConsoleUtils.readString('Enter your choice: ');

    switch (choice) {
      case '1':
        _addStudentMenu(recordService);
        break;
      case '2':
        recordService.displayAllStudents();
        break;
      case '3':
        _viewStudentMenu(recordService);
        break;
      case '4':
        _updateStudentMenu(recordService);
        break;
      case '5':
        _deleteStudentMenu(recordService);
        break;
      case '6':
        _searchStudentMenu(recordService);
        break;
      case '7':
        recordService.displayClassPerformance();
        break;
      case '8':
        authService.logout();
        break;
      default:
        print('Invalid choice. Please try again.');
    }

    if (authService.isLoggedIn) {
      ConsoleUtils.readString('\nPress enter to continue...');
    }
  }
}

void _addStudentMenu(SchoolRecordService service) {
  print('\nAdd New Student');
  print('-' * 20);

  final student = service.createStudentFromInput();
  service.addStudent(student);
}

void _viewStudentMenu(SchoolRecordService service) {
  print('\nView Student by ID');
  print('-' * 20);

  final id = ConsoleUtils.readString('Enter student ID: ');
  service.displayStudent(id);
}

void _updateStudentMenu(SchoolRecordService service) {
  print('\nUpdate Student');
  print('-' * 20);

  final id = ConsoleUtils.readString('Enter student ID to update: ');

  // Use the new public method
  final student = service.getStudent(id);
  if (student == null) {
    print('Student not found.');
    return;
  }

  print('Current student details:');
  print(student);

  final name = ConsoleUtils.readString(
    'Enter new name (leave blank to keep current): ',
  );
  final ageInput = ConsoleUtils.readString(
    'Enter new age (leave blank to keep current): ',
  );
  final age = ageInput.isEmpty ? null : int.tryParse(ageInput);
  final grade = ConsoleUtils.readString(
    'Enter new grade (leave blank to keep current): ',
  );

  final subjects = <String, double>{};
  var updateSubjects = false;

  final updateChoice = ConsoleUtils.readString(
    'Do you want to update subjects? (y/n): ',
  ).toLowerCase();
  if (updateChoice == 'y') {
    updateSubjects = true;
    var addMoreSubjects = true;

    while (addMoreSubjects) {
      final subject = ConsoleUtils.readString(
        'Enter subject name to update/add (or "done" to finish): ',
      );

      if (subject.toLowerCase() == 'done') {
        addMoreSubjects = false;
      } else {
        final marks = ConsoleUtils.readDouble('Enter marks for $subject (%): ');
        subjects[subject] = marks;
      }
    }
  }

  service.updateStudent(
    id,
    name: name.isEmpty ? null : name,
    age: age,
    grade: grade.isEmpty ? null : grade,
    subjects: updateSubjects ? subjects : null,
  );
}

void _deleteStudentMenu(SchoolRecordService service) {
  print('\nDelete Student');
  print('-' * 20);

  final id = ConsoleUtils.readString('Enter student ID to delete: ');
  service.deleteStudent(id);
}

void _searchStudentMenu(SchoolRecordService service) {
  print('\nSearch Students by Name');
  print('-' * 20);

  final name = ConsoleUtils.readString(
    'Enter name or part of name to search: ',
  );
  service.searchStudentsByName(name);
}
