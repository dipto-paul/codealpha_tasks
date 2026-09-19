import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/workout_model.dart';

class AddWorkoutScreen extends StatefulWidget {
  final Workout? workout;

  const AddWorkoutScreen({
    super.key,
    this.workout,
  });

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final caloriesController = TextEditingController();

  bool get isEditing => widget.workout != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      nameController.text = widget.workout!.name;
      durationController.text =
          widget.workout!.duration.toString();
      caloriesController.text =
          widget.workout!.calories.toString();
    }
  }

  Future<void> saveWorkout() async {
    if (nameController.text.trim().isEmpty ||
        durationController.text.trim().isEmpty ||
        caloriesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    final workout = Workout(
      id: widget.workout?.id,
      name: nameController.text.trim(),
      duration: int.tryParse(durationController.text.trim()) ?? 0,
      calories: int.tryParse(caloriesController.text.trim()) ?? 0,
    );

    if (isEditing) {
      await DatabaseHelper.instance.updateWorkout(workout);
    } else {
      await DatabaseHelper.instance.insertWorkout(workout);
    }

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    caloriesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Workout' : 'Add Workout',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Workout Name',
                hintText: 'e.g. Running',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fitness_center),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duration in Minutes',
                hintText: 'e.g. 30',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calories Burned',
                hintText: 'e.g. 200',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_fire_department),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveWorkout,
                icon: Icon(
                  isEditing ? Icons.save : Icons.add,
                ),
                label: Text(
                  isEditing ? 'Update Workout' : 'Add Workout',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}