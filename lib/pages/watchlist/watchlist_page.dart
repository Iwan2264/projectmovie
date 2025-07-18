import 'package:flutter/material.dart';
import 'package:projectmovie/pages/watchlist/widgets/top_bar.dart';
import 'package:projectmovie/pages/watchlist/widgets/watchlist_stats.dart';
class WatchlistPage extends StatelessWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example values, you can load these dynamically or via GetX controller
    final watchTime = 500.5;
    final meanScore = 7.65;
    final watched = 40;
    final planToWatch = 35;
    final rewatched = 15;
    final dropped = 10;
    final total = watched + planToWatch + rewatched + dropped;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Fixed header bar
          Container(
            width: double.infinity,
            height: 50,
            color: const Color(0xFF145C6E),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "User's Watchlist",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TopBar(
            watchTime: watchTime,
            meanScore: meanScore,
          ),
          WatchlistStats(
            watched: watched,
            planToWatch: planToWatch,
            rewatched: rewatched,
            dropped: dropped,
            total: total,
          ),
          // Add the rest of your watchlist page widgets below
        ],
      ),
    );
  }
}