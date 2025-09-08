import 'package:flutter/material.dart';
import 'screens/movie_ratings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ratings',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MovieRatingsScreen(),
    );
  }
}
