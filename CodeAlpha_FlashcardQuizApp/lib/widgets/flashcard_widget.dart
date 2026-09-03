import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onShowAnswer;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onShowAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.style,
            size: 55,
            color: Colors.deepPurple,
          ),

          const SizedBox(height: 25),

          Text(
            showAnswer ? "Answer" : "Question",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            showAnswer ? flashcard.answer : flashcard.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 30),

          if (!showAnswer)
            ElevatedButton(
              onPressed: onShowAnswer,
              child: const Text(
                "Show Answer",
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}