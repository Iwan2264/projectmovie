import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSectionWidget extends StatelessWidget {
  const SearchSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: '🔍 Search movies, actors, genres...',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  Get.snackbar('Filters', 'Advanced filters coming soon!');
                },
              ),
            ),
            onTap: () {
              Get.snackbar('Search', 'Search functionality coming soon!');
            },
          ),
        ),
        const SizedBox(height: 12),
        // Quick Filter Chips
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror', 'Romance']
                .map((genre) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(genre),
                        onSelected: (selected) {
                          Get.snackbar('Filter', 'Selected: $genre');
                        },
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}