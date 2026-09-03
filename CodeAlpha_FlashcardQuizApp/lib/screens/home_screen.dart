import 'package:flutter/material.dart';
import '../data/flashcard_data.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import 'add_flashcard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedTab = 0;

  int currentCardIndex = 0;

  bool showAnswer = false;

  Flashcard get currentFlashcard {
    return flashcards[currentCardIndex];
  }

  void showTheAnswer() {
    setState(() {
      showAnswer = true;
    });
  }

  void nextFlashcard() {
    if (currentCardIndex < flashcards.length - 1) {
      setState(() {
        currentCardIndex++;
        showAnswer = false;
      });
    }
  }

  void previousFlashcard() {
    if (currentCardIndex > 0) {
      setState(() {
        currentCardIndex--;
        showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: selectedTab == 0
          ? buildFlashcardScreen()
          : const AddFlashcardScreen(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,

        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: "Flashcards",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Card",
          ),
        ],
      ),
    );
  }

  Widget buildFlashcardScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: const Text("Flashcard Quiz"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              "Card ${currentCardIndex + 1} / ${flashcards.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 20),

            FlashcardWidget(
              flashcard: currentFlashcard,
              showAnswer: showAnswer,
              onShowAnswer: showTheAnswer,
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                ElevatedButton.icon(
                  onPressed: currentCardIndex > 0
                      ? previousFlashcard
                      : null,

                  icon: const Icon(Icons.arrow_back),

                  label: const Text("Previous"),
                ),

                ElevatedButton.icon(
                  onPressed:
                  currentCardIndex < flashcards.length - 1
                      ? nextFlashcard
                      : null,

                  icon: const Icon(Icons.arrow_forward),

                  label: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}