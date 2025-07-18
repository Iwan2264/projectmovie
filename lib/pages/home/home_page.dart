import 'package:flutter/material.dart';
import 'package:projectmovie/pages/home/home_widgets/dynamic_header_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/stat_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/moviecard_widget.dart';
import 'package:projectmovie/pages/home/home_widgets/home_watchlist_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          '🎬 Project Movie List',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            DynamicHeaderWidget(),
            SizedBox(height: 24),
            StatsSectionWidget(),
            SizedBox(height: 32),
            PopularMoviesWidget(),
            SizedBox(height: 32),
            HomeWatchlistWidget(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}