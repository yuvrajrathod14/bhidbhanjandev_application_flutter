import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.primaryDark, AppTheme.primaryDeep],
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  // Background icon
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Center(
                        child: Icon(
                          Icons.temple_hindu,
                          size: 160,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withAlpha(38),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'About Our Temple',
                            style: GoogleFonts.newsreader(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'श्री भीडभंजन हनुमान मंदिर, सकरिया',
                            style: GoogleFonts.newsreader(
                              color: Colors.white.withAlpha(204),
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ──
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Welcome card
                _buildWelcomeCard(),
                const SizedBox(height: 16),

                // Mantra banner
                _buildMantraBanner(),
                const SizedBox(height: 20),

                // History section
                _buildSection(
                  'Temple History',
                  Icons.auto_stories,
                  'Shree Bhidbhanjan Hanuman Temple, situated in the serene '
                      'village of Sakariya, Gujarat, is a sacred abode of Lord '
                      'Hanuman. The temple has served as a beacon of faith, '
                      'drawing devotees from across the region seeking blessings '
                      'and divine solace.',
                ),
                const SizedBox(height: 16),

                // Temple Highlights
                _buildHighlightsGrid(),
                const SizedBox(height: 16),

                // Architecture
                _buildSection(
                  'Architecture',
                  Icons.architecture,
                  'The temple features traditional Gujarati architecture with '
                      'intricate carvings and a magnificent shikhara (spire). '
                      'The sanctum sanctorum houses the revered idol of Lord '
                      'Hanuman, adorned with saffron and marigold garlands.',
                ),
                const SizedBox(height: 16),

                // Management
                _buildManagementCard(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      transform: Matrix4.translationValues(0, -12, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Text(
            'શ્રી ભીડભંજન હનુમાન મંદિર',
            style: GoogleFonts.newsreader(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Sakariya, Gujarat',
            style: GoogleFonts.newsreader(
              fontSize: 16,
              color: AppTheme.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMantraBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryDark],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'ॐ श्री हनुमते नमः',
        style: GoogleFonts.newsreader(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.orangeLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.newsreader(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: GoogleFonts.newsreader(
              fontSize: 15,
              color: AppTheme.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsGrid() {
    final highlights = [
      _Highlight(Icons.temple_hindu, 'Ancient\nTemple', AppTheme.orangeLight),
      _Highlight(Icons.self_improvement, 'Daily\nDarshan', AppTheme.blueLight),
      _Highlight(Icons.restaurant, 'Prasad\nSeva', AppTheme.purpleLight),
      _Highlight(Icons.park, 'Sacred\nGardens', AppTheme.roseLight),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Temple Highlights',
            style: GoogleFonts.newsreader(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemCount: highlights.length,
          itemBuilder: (context, i) {
            final h = highlights[i];
            return Container(
              decoration: BoxDecoration(
                color: h.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primaryColor.withAlpha(26)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(h.icon, color: AppTheme.primaryColor, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    h.label,
                    style: GoogleFonts.newsreader(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildManagementCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.blueLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.people,
                  color: Colors.blue.shade600,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Temple Management',
                style: GoogleFonts.newsreader(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _managementRow('Chief Priest', 'Shri Mahant Ji'),
          const SizedBox(height: 10),
          _managementRow('Contact', '+91 97279 05010'),
          const SizedBox(height: 10),
          _managementRow('Open', '5:30 AM - 9:30 PM'),
        ],
      ),
    );
  }

  Widget _managementRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.newsreader(
            fontSize: 14,
            color: AppTheme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.newsreader(
            fontSize: 14,
            color: AppTheme.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Highlight {
  final IconData icon;
  final String label;
  final Color color;
  _Highlight(this.icon, this.label, this.color);
}
