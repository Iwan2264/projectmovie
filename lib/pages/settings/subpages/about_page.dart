import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.movie, size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    'ProjectMovie',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'About This App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ProjectMovie is a Flutter application for discovering, saving, and managing your favorite movies. '
              'Browse trending films, customize your experience, and keep your watchlist organized.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Developed by:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Safwan'),
            const SizedBox(height: 24),
            const Text(
              'Contact & Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Email: wansaf05@gmail.com'),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '© 2025 ProjectMovie. All rights reserved.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}