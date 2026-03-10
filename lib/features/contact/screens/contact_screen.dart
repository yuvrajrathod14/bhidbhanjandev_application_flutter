import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Contact & Directions',
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
        children: [
          // ── Map Placeholder ──
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDQ4F7c5vA2_9g5cE5uTbQY7wL0hA2jK9xJ8xI2aN7rX5pQ7cE5aG6bH9kL8xJ2aN7rX5pQ7qR4tY5uI2oP6mN3xI2aN7rX5pQ7cE5aG6bH9kL8xJ2aN7rX5pQ7', // placeholder map idea
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.grey, // Fallback if image fails
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black.withAlpha(51)),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.directions,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Get Directions',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shree Hanumanji Temple',
                  style: GoogleFonts.newsreader(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sarangpur, Gujarat 382715\nIndia',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppTheme.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // ── Contact Methods ──
                _buildContactRow(
                  icon: Icons.phone_in_talk_outlined,
                  title: 'Phone',
                  subtitle: '+91 98765 43210\n+91 98765 43211',
                  actionText: 'Call Now',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.black12),
                ),
                _buildContactRow(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle:
                      'info@sarangpurtemple.org\nsupport@sarangpurtemple.org',
                  actionText: 'Send Email',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.black12),
                ),
                _buildContactRow(
                  icon: Icons.access_time,
                  title: 'Prasad Timings',
                  subtitle:
                      'Morning: 11:30 AM to 02:00 PM\nEvening: 07:30 PM to 09:30 PM',
                  actionText: '',
                  showAction: false,
                ),

                const SizedBox(height: 32),

                // ── Social Media ──
                Text(
                  'Connect With Us',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildSocialIcon('Facebook', Icons.facebook),
                    const SizedBox(width: 16),
                    _buildSocialIcon('Instagram', Icons.camera_alt),
                    const SizedBox(width: 16),
                    _buildSocialIcon('YouTube', Icons.play_circle_filled),
                    const SizedBox(width: 16),
                    _buildSocialIcon('Twitter', Icons.flutter_dash),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    bool showAction = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withAlpha(26),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppTheme.textMuted,
                  height: 1.5,
                ),
              ),
              if (showAction) ...[
                const SizedBox(height: 8),
                Text(
                  actionText,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppTheme.textDark),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
        ),
      ],
    );
  }
}
