import 'dart:math';

import 'package:flutter/material.dart';

import '../data/quote_data.dart';
import '../model/quote_model.dart';
import '../widgets/quote_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuoteModel currentQuote = quotes[0];

  int currentIndex = 0;

  List<QuoteModel> favorites = [];

  void getNewQuote() {
    final random = Random();

    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];
    });
  }

  void toggleFavorite() {
    setState(() {
      if (favorites.contains(currentQuote)) {
        favorites.remove(currentQuote);
      } else {
        favorites.add(currentQuote);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      buildQuoteScreen(),
      FavoritesScreen(
        favorites: favorites,
        onRemove: (quote) {
          setState(() {
            favorites.remove(quote);
          });
        },
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: "Quote",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }

  Widget buildQuoteScreen() {
    final bool isFavorite = favorites.contains(currentQuote);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),

      appBar: AppBar(
        title: const Text("Random Quote Generator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            QuoteCard(
              quote: currentQuote,
            ),

            const SizedBox(height: 20),

            IconButton(
              onPressed: toggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              iconSize: 40,
              color: Colors.red,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: getNewQuote,

                icon: const Icon(Icons.refresh),

                label: const Text(
                  "New Quote",
                  style: TextStyle(
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