import 'package:flutter/material.dart';
import '../model/quote_model.dart';


class QuoteCard extends StatelessWidget {
  final QuoteModel quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

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
        children: [
          const Icon(
            Icons.format_quote,
            size: 50,
            color: Colors.deepPurple,
          ),

          const SizedBox(height: 20),

          Text(
            quote.quote,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "- ${quote.author}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}