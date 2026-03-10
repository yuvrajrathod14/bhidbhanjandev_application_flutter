import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../settings/screens/settings_screen.dart';
import '../../donation/screens/donation_screen.dart';
import '../../contact/screens/contact_screen.dart';
import '../../darshan/screens/live_darshan_screen.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../bookmarks/screens/bookmarks_screen.dart';
import '../../facilities/screens/facilities_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            backgroundColor: AppTheme.backgroundColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'More',
              style: GoogleFonts.newsreader(
                fontSize: context.sp(24),
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: AppTheme.textDark,
                  size: context.w(24),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
              SizedBox(width: context.w(8)),
            ],
          ),

          // ── User Profile Header ──
          SliverToBoxAdapter(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String name = 'Guest User';
                String subtitle = 'Login to sync data';
                String initial = 'G';

                if (state is Authenticated) {
                  final user = state.user as User;
                  name =
                      user.displayName ??
                      user.email?.split('@').first ??
                      'User';
                  subtitle =
                      user.phoneNumber ?? user.email ?? 'No contact info';
                  initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';
                }

                return Padding(
                  padding: EdgeInsets.all(context.w(20)),
                  child: Row(
                    children: [
                      Container(
                        width: context.w(70),
                        height: context.w(70),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor.withAlpha(51),
                          border: Border.all(
                            color: AppTheme.primaryColor.withAlpha(128),
                            width: context.w(2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            initial,
                            style: TextStyle(
                              fontSize: context.sp(32),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: context.w(16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.newsreader(
                                fontSize: context.sp(22),
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            SizedBox(height: context.h(4)),
                            Text(
                              subtitle,
                              style: GoogleFonts.newsreader(
                                fontSize: context.sp(14),
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade400,
                        size: context.w(24),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ── Navigation Grid ──
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.w(20)),
            sliver: SliverGrid.count(
              crossAxisCount: context.isMobile ? 2 : 3,
              mainAxisSpacing: context.h(16),
              crossAxisSpacing: context.w(16),
              childAspectRatio: 1.1,
              children: [
                _buildNavCard(
                  context,
                  'Live Darshan',
                  Icons.videocam_outlined,
                  Colors.blue,
                  const LiveDarshanScreen(),
                ),
                _buildNavCard(
                  context,
                  'Donation',
                  Icons.volunteer_activism_outlined,
                  Colors.green,
                  const DonationScreen(),
                ),
                _buildNavCard(
                  context,
                  'Facilities',
                  Icons.storefront_outlined,
                  Colors.orange,
                  const FacilitiesScreen(),
                ),
                _buildNavCard(
                  context,
                  'Contact Us',
                  Icons.contact_support_outlined,
                  Colors.purple,
                  const ContactScreen(),
                ),
                _buildNavCard(
                  context,
                  'Bookmarks',
                  Icons.bookmark_outline,
                  Colors.teal,
                  const BookmarksScreen(),
                ),
                _buildNavCard(
                  context,
                  'Notifications',
                  Icons.notifications_none_outlined,
                  Colors.red,
                  const NotificationsScreen(),
                ),
              ],
            ),
          ),

          // ── Bottom Spacing ──
          SliverToBoxAdapter(child: SizedBox(height: context.h(32))),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget destination,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => destination),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.w(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: context.w(10),
              offset: Offset(0, context.h(4)),
            ),
          ],
        ),
        padding: EdgeInsets.all(context.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(context.w(12)),
              decoration: BoxDecoration(
                color: color.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: context.w(28)),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.newsreader(
                fontSize: context.sp(16),
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
