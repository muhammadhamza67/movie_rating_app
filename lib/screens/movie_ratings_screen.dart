import 'package:flutter/material.dart';
import '../services/movie_api_service.dart';

class MovieRatingsScreen extends StatefulWidget {
  const MovieRatingsScreen({super.key});

  @override
  State<MovieRatingsScreen> createState() => _MovieRatingsScreenState();
}

class _MovieRatingsScreenState extends State<MovieRatingsScreen> {
  final TextEditingController _controller =
      TextEditingController(text: "tt0111161"); // Default: Shawshank Redemption
  Map<String, dynamic>? _movieData;
  bool _loading = false;
  String? _error;

  Future<void> _fetchRatings() async {
    setState(() {
      _loading = true;
      _error = null;
      _movieData = null;
    });

    try {
      final data = await MovieApiService.getRatings(_controller.text.trim());
      setState(() {
        _movieData = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildRatings(Map<String, dynamic> ratings) {
    final Map<String, IconData> icons = {
      "imdb": Icons.star,
      "rottenTomatoes": Icons.local_pizza, // 🍅 substitute
      "metacritic": Icons.tv,
    };

    return Column(
      children: ratings.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange.withOpacity(0.8),
              child: Icon(icons[entry.key] ?? Icons.movie, color: Colors.white),
            ),
            title: Text(
              entry.key.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: Text(
              entry.value.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.yellow,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("🎬 Movie Ratings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input field
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Enter IMDb ID (e.g. tt1375666)",
                  labelStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Fetch button
            ElevatedButton.icon(
              onPressed: _fetchRatings,
              icon: const Icon(Icons.search),
              label: const Text("Get Ratings"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Content
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                  : _error != null
                      ? Center(
                          child: Text(
                            "⚠️ $_error",
                            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : _movieData != null
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Poster
                                  if (_movieData!["image"] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        _movieData!["image"],
                                        height: 260,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  const SizedBox(height: 16),

                                  // Title
                                  if (_movieData!["title"] != null)
                                    Text(
                                      _movieData!["title"],
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),

                                  const SizedBox(height: 24),

                                  // Ratings
                                  if (_movieData!["ratings"] != null)
                                    _buildRatings(
                                      Map<String, dynamic>.from(_movieData!["ratings"]),
                                    ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Enter an IMDb ID and press Search",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
