import 'package:flutter/material.dart';

class WatchlistAndRating extends StatelessWidget {
  final VoidCallback? onWatchlistTap;
  final VoidCallback? onRateTap;

  const WatchlistAndRating({
    super.key,
    this.onWatchlistTap,
    this.onRateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 50,
          color: const Color(0xFFD9D9D9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add to Watchlist Button
              InkWell(
                onTap: onWatchlistTap,
                child: Row(
                  children: const [
                    Icon(Icons.add, size: 24, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Add to Watchlist',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Self Rating Text
              InkWell(
                onTap: onRateTap,
                child: const Text(
                  'Rate This!',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
