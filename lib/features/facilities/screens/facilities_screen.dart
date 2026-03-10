import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class FacilitiesScreen extends StatelessWidget {
  const FacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Temple Facilities',
          style: GoogleFonts.newsreader(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFacilityCard(
            context,
            title: 'Bhojanalaya (Dining Hall)',
            description:
                'Free prasadam meals are served to all devotees daily. Serving thousands of people with pure vegetarian food.',
            icon: Icons.restaurant,
            imagePath:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuD4V64AgCe4YIcqAjheVuGHTtu0wrdCj7ZM6E_BbRVeIvAbDSRXF5vSmnztQq2BaHWtUYWFBQJbzqGppDQwpNxVEZvrUhViUT0es86VPP6BAQXY-tchDYaZYTJ73vSv6Kw6ThsMELiMxMNI9LlRwBGwoa6q4vQMNKMao3cDbLAEkt8Z0u9PNdl1NMVidKi2OkZdycQxZz9RU94RbUZfY-IgTWH1KkPOcfKsgRuDLcNNQ3QGQGEMuBFjN_fIHYOlr0mZ17ynpCA3P9Q', // Placeholder
            timings: '11:30 AM - 2:00 PM | 7:30 PM - 9:30 PM',
          ),
          const SizedBox(height: 16),
          _buildFacilityCard(
            context,
            title: 'Dharamshala (Accommodation)',
            description:
                'Clean and comfortable rooms available for devotees to stay overnight. Prior booking is recommended during festivals.',
            icon: Icons.hotel,
            imagePath:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDQ4F7c5vA2_9g5cE5uTbQY7wL0hA2jK9xJ8xI2aN7rX5pQ7cE5aG6bH9kL8xJ2aN7rX5pQ7qR4tY5uI2oP6mN3xI2aN7rX5pQ7cE5aG6bH9kL8xJ2aN7rX5pQ7', // Placeholder
            timings: '24/7 Reception',
          ),
          const SizedBox(height: 16),
          _buildFacilityCard(
            context,
            title: 'Gaushala',
            description:
                'Over 100 cows are sheltered and cared for. Devotees can feed the cows and donate grass.',
            icon: Icons.pets, // closest to cow in default icons
            imagePath:
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBAzHBxDnLXwTXFnpEeSNWS_OvO03Y5QXd2INRYFS7RMTuYPkfR05WKjKAch9NePrAfNdZo05u9otnIVYFB8xUttbs-D8mBpZfy7GzlIhTB9QMBdr5wdVqjmkQI5rvn-SVkPsQGMRpINRDa1vkHVfYu9-1rf2zy6TSAzOqfqubLSN44evhZWp2nZ8-w-DFaaUCe-LxY8ohsfXix1GD1ykiX-STuX7yplnuAtb7FqrE9hNQXAxD_jPzMELk4Y1hCZHnRMj3-UZiieMg',
            timings: '8:00 AM - 6:00 PM',
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required String imagePath,
    required String timings,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.newsreader(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timings,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
