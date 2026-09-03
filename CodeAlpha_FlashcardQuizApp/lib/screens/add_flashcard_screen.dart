import 'package:flutter/material.dart';
import '../data/flashcard_data.dart';
import '../models/flashcard_model.dart';

class AddFlashcardScreen extends StatefulWidget {
  final int? editIndex;
  final VoidCallback? onSaved;

  const AddFlashcardScreen({
    super.key,
    this.editIndex,
    this.onSaved,
  });

  @override
  State<AddFlashcardScreen> createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final TextEditingController questionController =
  TextEditingController();

  final TextEditingController answerController =
  TextEditingController();

  bool get isEditing => widget.editIndex != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final flashcard = flashcards[widget.editIndex!];

      questionController.text = flashcard.question;
      answerController.text = flashcard.answer;
    }
  }

  void saveFlashcard() {
    if (questionController.text.trim().isEmpty ||
        answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter question and answer"),
        ),
      );

      return;
    }

    if (isEditing) {
      flashcards[widget.editIndex!] = Flashcard(
        question: questionController.text.trim(),
        answer: answerController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Flashcard updated successfully"),
        ),
      );
    } else {
      flashcards.add(
        Flashcard(
          question: questionController.text.trim(),
          answer: answerController.text.trim(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Flashcard added successfully"),
        ),
      );
    }

    widget.onSaved?.call();
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Flashcard" : "Add Flashcard",
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
              controller: questionController,
              decoration: InputDecoration(
                labelText: "Question",
                hintText: "Enter your question",
                prefixIcon: const Icon(Icons.help_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: answerController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Answer",
                hintText: "Enter the answer",
                prefixIcon: const Icon(Icons.lightbulb_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: saveFlashcard,

                icon: Icon(
                  isEditing ? Icons.save : Icons.add,
                ),

                label: Text(
                  isEditing
                      ? "Update Flashcard"
                      : "Add Flashcard",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}