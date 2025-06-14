class Student {
  final String id;
  final String name;
  final int age;
  final String grade;
  final Map<String, double> subjects;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.grade,
    required this.subjects,
  });

  double get averageScore {
    if (subjects.isEmpty) return 0.0;
    return subjects.values.reduce((a, b) => a + b) / subjects.length;
  }

  String get performance {
    final avg = averageScore;
    if (avg >= 90) return 'Excellent';
    if (avg >= 75) return 'Very Good';
    if (avg >= 60) return 'Good';
    if (avg >= 40) return 'Average';
    return 'Poor';
  }

  @override
  String toString() {
    return '''
ID: $id
Name: $name
Age: $age
Grade: $grade
Subjects: ${subjects.map((key, value) => MapEntry(key, '${value.toStringAsFixed(2)}%'))}
Average Score: ${averageScore.toStringAsFixed(2)}%
Performance: $performance
''';
  }
}
