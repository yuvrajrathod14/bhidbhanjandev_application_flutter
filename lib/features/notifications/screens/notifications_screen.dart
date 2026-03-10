import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive_utils.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.newsreader(
            fontSize: context.sp(20),
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.textDark,
            size: context.w(24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Action coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              'Mark all read',
              style: GoogleFonts.inter(
                color: AppTheme.primaryColor,
                fontSize: context.sp(14),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildNotificationGroup(context, 'Today'),
          _buildNotificationItem(
            context,
            icon: Icons.event,
            iconColor: Colors.blue,
            title: 'Maha Aarti starts in 15 minutes',
            time: '18:45 PM',
            isUnread: true,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.volunteer_activism,
            iconColor: Colors.green,
            title: 'Thank you for your donation!',
            time: '14:20 PM',
            isUnread: true,
            hasAction: true,
          ),
          _buildNotificationGroup(context, 'Yesterday'),
          _buildNotificationItem(
            context,
            icon: Icons.campaign,
            iconColor: Colors.orange,
            title: 'New Temple Schedule Announced',
            time: '09:00 AM',
            isUnread: false,
          ),
          _buildNotificationItem(
            context,
            icon: Icons.photo_library,
            iconColor: Colors.purple,
            title: 'New album added: Hanuman Jayanti Highlights',
            time: 'Yesterday',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(24),
        context.w(16),
        context.h(8),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: context.sp(14),
          fontWeight: FontWeight.bold,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required bool isUnread,
    bool hasAction = false,
  }) {
    return Container(
      color: isUnread ? iconColor.withAlpha(13) : Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.w(12)),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: context.w(24)),
          ),
          SizedBox(width: context.w(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: context.sp(16),
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                    color: AppTheme.textDark,
                  ),
                ),
                SizedBox(height: context.h(4)),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: context.sp(13),
                    color: AppTheme.textMuted,
                  ),
                ),
                if (hasAction) ...[
                  SizedBox(height: context.h(12)),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Action coming soon!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w(20)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.w(16),
                        vertical: context.h(8),
                      ),
                    ),
                    child: Text(
                      'View Receipt',
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isUnread)
            Container(
              width: context.w(8),
              height: context.w(8),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
