import '../models/student.dart';
import '../utils/console_utils.dart';

class SchoolRecordService {
  final Map<String, Student> _students = {};

  void addStudent(Student student) {
    _students[student.id] = student;
    print('Student ${student.name} added successfully.');
  }

  void displayStudent(String id) {
    final student = _students[id];
    if (student != null) {
      print(student);
    } else {
      print('Student with ID $id not found.');
    }
  }

  void displayAllStudents() {
    if (_students.isEmpty) {
      print('No students in the record.');
      return;
    }
    _students.values.forEach((student) {
      print(student);
      print('-' * 30);
    });
  }

  void updateStudent(
    String id, {
    String? name,
    int? age,
    String? grade,
    Map<String, double>? subjects,
  }) {
    final student = _students[id];
    if (student != null) {
      _students[id] = Student(
        id: id,
        name: name ?? student.name,
        age: age ?? student.age,
        grade: grade ?? student.grade,
        subjects: subjects ?? student.subjects,
      );
      print('Student updated successfully.');
    } else {
      print('Student with ID $id not found.');
    }
  }

  void deleteStudent(String id) {
    if (_students.remove(id) != null) {
      print('Student deleted successfully.');
    } else {
      print('Student with ID $id not found.');
    }
  }

  void searchStudentsByName(String name) {
    final matches = _students.values.where(
      (student) => student.name.toLowerCase().contains(name.toLowerCase()),
    );
    if (matches.isEmpty) {
      print('No students found with name containing "$name".');
    } else {
      matches.forEach((student) {
        print(student);
        print('-' * 30);
      });
    }
  }

  void displayClassPerformance() {
    if (_students.isEmpty) {
      print('No students in the record.');
      return;
    }

    final sortedStudents = _students.values.toList()
      ..sort((a, b) => b.averageScore.compareTo(a.averageScore));

    print('\nClass Performance Ranking:');
    print('=' * 30);
    for (int i = 0; i < sortedStudents.length; i++) {
      print(
        '${i + 1}. ${sortedStudents[i].name} - ${sortedStudents[i].averageScore.toStringAsFixed(2)}% (${sortedStudents[i].performance})',
      );
    }
  }

  Student? getStudent(String id) {
    return _students[id];
  }

  Student createStudentFromInput() {
    final id = ConsoleUtils.readString('Enter student ID: ');
    final name = ConsoleUtils.readString('Enter student name: ');
    final age = ConsoleUtils.readInt('Enter student age: ');
    final grade = ConsoleUtils.readString('Enter student grade: ');

    final subjects = <String, double>{};
    var addMoreSubjects = true;

    while (addMoreSubjects) {
      final subject = ConsoleUtils.readString(
        'Enter subject name (or "done" to finish): ',
      );

      if (subject.toLowerCase() == 'done') {
        addMoreSubjects = false;
      } else {
        final marks = ConsoleUtils.readDouble('Enter marks for $subject (%): ');
        subjects[subject] = marks;
      }
    }

    return Student(
      id: id,
      name: name,
      age: age,
      grade: grade,
      subjects: subjects,
    );
  }
}
