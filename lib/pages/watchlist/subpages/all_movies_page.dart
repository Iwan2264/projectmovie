import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projectmovie/controllers/movie_controllers/watchlist_controller.dart';
import 'package:projectmovie/models/watchlist_entry.dart';
import 'package:projectmovie/pages/movie/movie_details_page.dart';
import 'package:projectmovie/utils/date_formatter.dart';
import 'package:projectmovie/pages/movie/movie_list_page.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  final WatchlistController controller = Get.find<WatchlistController>();
  final TextEditingController searchController = TextEditingController();
  
  WatchStatus? selectedFilter;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Watchlist'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(colorScheme),
          Expanded(
            child: Obx(() {
              final filteredMovies = _getFilteredMovies();
              
              if (filteredMovies.isEmpty) {
                return _buildEmptyState(colorScheme);
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final entry = filteredMovies[index];
                  return _buildMovieCard(entry, colorScheme);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search your watchlist...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 12),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', null, colorScheme),
                const SizedBox(width: 8),
                _buildFilterChip('Plan to Watch', WatchStatus.planToWatch, colorScheme),
                const SizedBox(width: 8),
                _buildFilterChip('Watched', WatchStatus.watched, colorScheme),
                const SizedBox(width: 8),
                _buildFilterChip('Rewatched', WatchStatus.rewatched, colorScheme),
                const SizedBox(width: 8),
                _buildFilterChip('Dropped', WatchStatus.dropped, colorScheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, WatchStatus? status, ColorScheme colorScheme) {
    final isSelected = selectedFilter == status;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: colorScheme.surface,
      selectedColor: colorScheme.primary.withAlpha((0.2 * 255).round()),
      checkmarkColor: colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildMovieCard(WatchlistEntry entry, ColorScheme colorScheme) {
    final movie = entry.movie;
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      elevation: 2,
      child: InkWell(
        onTap: () => Get.to(() => MovieDetailsPage(movieId: movie.id)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 120,
                      color: colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.movie,
                        color: colorScheme.onSurfaceVariant,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Movie details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatDate(movie.releaseDate),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: movie.voteAverage / 2,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                          unratedColor: colorScheme.outlineVariant.withAlpha((0.3 * 255).round()),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Status and actions
                    Row(
                      children: [
                        _buildStatusChip(entry, colorScheme),
                        const Spacer(),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: colorScheme.onSurface.withAlpha((0.6 * 255).round()),
                          ),
                          onSelected: (value) => _handleMenuAction(value, entry),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'change_status',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Change Status'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'remove',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Remove', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(WatchlistEntry entry, ColorScheme colorScheme) {
    final statusColors = {
      WatchStatus.planToWatch: Colors.blue,
      WatchStatus.watched: Colors.green,
      WatchStatus.rewatched: Colors.purple,
      WatchStatus.dropped: Colors.red,
    };

    final statusLabels = {
      WatchStatus.planToWatch: 'Plan to Watch',
      WatchStatus.watched: 'Watched',
      WatchStatus.rewatched: 'Rewatched',
      WatchStatus.dropped: 'Dropped',
    };

    final color = statusColors[entry.status] ?? Colors.grey;
    final label = statusLabels[entry.status] ?? 'Unknown';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha((0.3 * 255).round())),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    if (searchQuery.isNotEmpty || selectedFilter != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: colorScheme.onSurface.withAlpha((0.4 * 255).round()),
            ),
            const SizedBox(height: 16),
            Text(
              'No movies found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha((0.6 * 255).round()),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                  selectedFilter = null;
                });
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: colorScheme.onSurface.withAlpha((0.4 * 255).round()),
          ),
          const SizedBox(height: 16),
          Text(
            'Your watchlist is empty',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Start adding movies you want to watch!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha((0.6 * 255).round()),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.to(() => MovieListPage()),
            icon: const Icon(Icons.explore),
            label: const Text('Browse Movies'),
          ),
        ],
      ),
    );
  }

  List<WatchlistEntry> _getFilteredMovies() {
    var movies = controller.watchlist;

    // Filter by status
    if (selectedFilter != null) {
      movies = movies.where((entry) => entry.status == selectedFilter).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      movies = movies.where((entry) => 
        entry.movie.title.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return movies;
  }

  void _handleMenuAction(String action, WatchlistEntry entry) {
    switch (action) {
      case 'change_status':
        _showStatusDialog(entry);
        break;
      case 'remove':
        _showRemoveDialog(entry);
        break;
    }
  }

  void _showStatusDialog(WatchlistEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: WatchStatus.values.map((status) {
            final statusLabels = {
              WatchStatus.planToWatch: 'Plan to Watch',
              WatchStatus.watched: 'Watched',
              WatchStatus.rewatched: 'Rewatched',
              WatchStatus.dropped: 'Dropped',
            };

            return ListTile(
              title: Text(statusLabels[status] ?? 'Unknown'),
              leading: Radio<WatchStatus>(
                value: status,
                groupValue: entry.status,
                onChanged: (value) {
                  if (value != null) {
                    controller.setStatus(entry.movie, value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              onTap: () {
                controller.setStatus(entry.movie, status);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(WatchlistEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Movie'),
        content: Text('Are you sure you want to remove "${entry.movie.title}" from your watchlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.removeFromWatchlist(entry.movie);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}