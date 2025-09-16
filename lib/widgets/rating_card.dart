import 'package:flutter/material.dart';

// ✅ Reusable RatingCard widget
class RatingCard extends StatelessWidget {
  final String title;
  final String value;

  const RatingCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: Colors.grey.shade100,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Movie title on left
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Rating with star icon on right
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Main Movie Ratings Screen
class MovieRatingsScreen extends StatelessWidget {
  const MovieRatingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data (replace with API results later)
    final movies = [
      {"title": "The Shawshank Redemption", "rating": "9.3"},
      {"title": "The Godfather", "rating": "9.2"},
      {"title": "The Dark Knight", "rating": "9.0"},
      {"title": "Inception", "rating": "8.8"},
      {"title": "Interstellar", "rating": "8.6"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("🎬 Movie Ratings"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return RatingCard(
            title: movie["title"]!,
            value: movie["rating"]!,
          );
        },
      ),
    );
  }
}
