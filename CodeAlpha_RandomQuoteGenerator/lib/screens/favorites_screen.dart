import 'package:flutter/material.dart';

import '../model/quote_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<QuoteModel> favorites;

  final Function(QuoteModel) onRemove;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: favorites.isEmpty ? const Center(
        child: Text(
          "No Favorite Quotes Yet",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) : ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: favorites.length,

        itemBuilder: (context, index) {
          final quote = favorites[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    '"${quote.quote}"',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "- ${quote.author}",
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,

                    child: IconButton(
                      onPressed: () {
                        onRemove(quote);
                      },

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}