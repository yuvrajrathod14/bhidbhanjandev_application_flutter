import 'package:flutter/material.dart';

class QuickLinksGrid extends StatelessWidget {
  const QuickLinksGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final links = [
      {
        'title': 'Timings',
        'icon': Icons.access_time_rounded,
        'color': Colors.orange.shade400,
        'route': '/timings', // Will implement routing later
      },
      {
        'title': 'Events',
        'icon': Icons.event_rounded,
        'color': Colors.blue.shade400,
        'route': '/events',
      },
      {
        'title': 'Gallery',
        'icon': Icons.photo_library_rounded,
        'color': Colors.purple.shade400,
        'route': '/gallery',
      },
      {
        'title': 'Donation',
        'icon': Icons.volunteer_activism_rounded,
        'color': Colors.green.shade400,
        'route': '/donation',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Links',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: links.length,
            itemBuilder: (context, index) {
              final link = links[index];
              return _QuickLinkItem(
                title: link['title'] as String,
                icon: link['icon'] as IconData,
                color: link['color'] as Color,
                onTap: () {
                  // TODO: Implement actual navigation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Navigating to ${link['title']}...'),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickLinkItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickLinkItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: color.withAlpha(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withAlpha(30), width: 1),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
