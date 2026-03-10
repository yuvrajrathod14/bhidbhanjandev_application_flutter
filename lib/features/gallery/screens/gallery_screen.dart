import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import 'gallery_viewer_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All', 'Temple', 'Idol', 'Festivals', 'Videos'];

  // Sample gallery items
  final List<_GalleryItem> _items = [
    _GalleryItem(
      'Temple Exterior',
      'Temple',
      3 / 4,
      Icons.temple_hindu,
      Colors.amber,
      false,
    ),
    _GalleryItem(
      'Festival Lights',
      'Festival',
      1,
      Icons.celebration,
      Colors.pink,
      false,
    ),
    _GalleryItem(
      'Puja Ceremony',
      'Video',
      1,
      Icons.self_improvement,
      Colors.purple,
      true,
    ),
    _GalleryItem(
      'Stone Carvings',
      'Temple',
      3 / 4,
      Icons.architecture,
      Colors.brown,
      false,
    ),
    _GalleryItem('Deity Idol', 'Idol', 4 / 5, Icons.spa, Colors.teal, false),
    _GalleryItem(
      'Evening Aarti',
      'Video',
      4 / 3,
      Icons.local_fire_department,
      Colors.orange,
      true,
    ),
    _GalleryItem('Hanuman Murti', 'Idol', 1, Icons.favorite, Colors.red, false),
    _GalleryItem(
      'Diwali Decor',
      'Festival',
      3 / 4,
      Icons.light,
      Colors.yellow,
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.primaryColor),
              onPressed: () => Navigator.maybePop(context),
            ),
            title: Text(
              'Gallery',
              style: GoogleFonts.newsreader(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppTheme.primaryColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Action coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.tune, color: AppTheme.primaryColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Action coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _buildTabs(),
            ),
          ),

          // ── Masonry Grid ──
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(child: _buildMasonryGrid()),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppTheme.primaryColor.withAlpha(51)),
        ),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final selected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected
                          ? AppTheme.primaryColor
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.newsreader(
                    fontSize: 14,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    color: selected
                        ? AppTheme.primaryColor
                        : AppTheme.textMuted,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMasonryGrid() {
    final leftCol = <_GalleryItem>[];
    final rightCol = <_GalleryItem>[];
    for (int i = 0; i < _items.length; i++) {
      if (i.isEven) {
        leftCol.add(_items[i]);
      } else {
        rightCol.add(_items[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildColumn(leftCol, 0)),
        const SizedBox(width: 12),
        Expanded(child: _buildColumn(rightCol, 1)),
      ],
    );
  }

  Widget _buildColumn(List<_GalleryItem> items, int colIndex) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 300 + (colIndex * 2 + index) * 80),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: 0.9 + 0.1 * value, child: child),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildGridItem(item),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGridItem(_GalleryItem item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GalleryViewerScreen(title: item.title),
        ),
      ),
      child: AspectRatio(
        aspectRatio: item.aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [item.color.withAlpha(77), item.color.withAlpha(38)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  item.icon,
                  size: 48,
                  color: item.color.withAlpha(128),
                ),
              ),
              // Category label
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.isVideo) ...[
                        const Icon(
                          Icons.videocam,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        item.category,
                        style: GoogleFonts.newsreader(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Play button for videos
              if (item.isVideo)
                Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha(230),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryItem {
  final String title;
  final String category;
  final double aspectRatio;
  final IconData icon;
  final Color color;
  final bool isVideo;

  _GalleryItem(
    this.title,
    this.category,
    this.aspectRatio,
    this.icon,
    this.color,
    this.isVideo,
  );
}
