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


  Future<void> editFlashcard() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFlashcardScreen(
          editIndex: currentCardIndex,
        ),
      ),
    );

    if (result == true) {
      setState(() {
        showAnswer = false;
      });
    }
  }


  void deleteFlashcard() {

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Flashcard?"),

          content: const Text(
            "Are you sure you want to delete this flashcard?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () {

                setState(() {

                  flashcards.removeAt(currentCardIndex);

                  if (flashcards.isEmpty) {
                    currentCardIndex = 0;
                  } else if (
                  currentCardIndex >= flashcards.length) {
                    currentCardIndex = flashcards.length - 1;
                  }

                  showAnswer = false;
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Flashcard deleted successfully",
                    ),
                  ),
                );
              },

              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: selectedTab == 0
          ? buildFlashcardScreen()
          : AddFlashcardScreen(
        onSaved: () {
          setState(() {
            selectedTab = 0;
            currentCardIndex = flashcards.length - 1;
            showAnswer = false;
          });
        },
      ),

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

    if (flashcards.isEmpty) {
      return Scaffold(

        appBar: AppBar(
          title: const Text("Flashcard Quiz"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),

        backgroundColor: const Color(0xFFF5F3FF),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.style_outlined,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                "No Flashcards Available",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Add a new flashcard to start learning.",
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    selectedTab = 1;
                  });
                },

                icon: const Icon(Icons.add),

                label: const Text("Add Flashcard"),
              ),
            ],
          ),
        ),
      );
    }

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

              onEdit: editFlashcard,

              onDelete: deleteFlashcard,
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