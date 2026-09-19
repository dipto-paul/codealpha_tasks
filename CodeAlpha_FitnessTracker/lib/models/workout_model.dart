class Workout {
  int? id;
  String name;
  int duration;
  int calories;

  Workout({
    this.id,
    required this.name,
    required this.duration,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'calories': calories,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
      calories: map['calories'],
    );
  }
}