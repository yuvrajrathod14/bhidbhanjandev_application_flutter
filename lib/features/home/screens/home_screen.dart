import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../timings/screens/timings_screen.dart';
import '../../events/screens/events_screen.dart';
import '../../gallery/screens/gallery_screen.dart';
import '../../donation/screens/donation_screen.dart';
import '../../darshan/screens/live_darshan_screen.dart';
import '../../contact/screens/contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggerController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Animation<double> _staggerFade(double start, double end) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<Offset> _staggerSlide(double start, double end) {
    return Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ═══ TOP BAR ═══
            FadeTransition(
              opacity: _staggerFade(0.0, 0.2),
              child: _buildTopBar(context),
            ),

            // ═══ SEARCH BAR ═══
            FadeTransition(
              opacity: _staggerFade(0.1, 0.3),
              child: _buildSearchBar(context),
            ),

            SizedBox(height: context.h(16)),

            // ═══ HERO BANNER ═══
            FadeTransition(
              opacity: _staggerFade(0.2, 0.4),
              child: _buildHeroBanner(context),
            ),

            SizedBox(height: context.h(16)),

            // ═══ STATUS CARD ═══
            SlideTransition(
              position: _staggerSlide(0.3, 0.5),
              child: FadeTransition(
                opacity: _staggerFade(0.3, 0.5),
                child: _buildStatusCard(context),
              ),
            ),

            SizedBox(height: context.h(24)),

            // ═══ QUICK LINKS GRID ═══
            SlideTransition(
              position: _staggerSlide(0.4, 0.6),
              child: FadeTransition(
                opacity: _staggerFade(0.4, 0.6),
                child: _buildQuickLinksGrid(context),
              ),
            ),

            SizedBox(height: context.h(32)),

            // ═══ TODAY'S SCHEDULE ═══
            SlideTransition(
              position: _staggerSlide(0.5, 0.7),
              child: FadeTransition(
                opacity: _staggerFade(0.5, 0.7),
                child: _buildTodaysSchedule(context),
              ),
            ),

            SizedBox(height: context.h(32)),

            // ═══ UPCOMING EVENTS ═══
            SlideTransition(
              position: _staggerSlide(0.6, 0.8),
              child: FadeTransition(
                opacity: _staggerFade(0.6, 0.8),
                child: _buildUpcomingEvents(context),
              ),
            ),

            SizedBox(height: context.h(32)),

            // ═══ TEMPLE INFO CARD ═══
            SlideTransition(
              position: _staggerSlide(0.7, 0.9),
              child: FadeTransition(
                opacity: _staggerFade(0.7, 0.9),
                child: _buildTempleInfoCard(context),
              ),
            ),

            SizedBox(height: context.h(40)),
          ],
        ),
      ),
    );
  }

  // ───────────────── TOP BAR ─────────────────
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(12),
        context.w(16),
        0,
      ),
      child: Row(
        children: [
          Container(
            width: context.w(42),
            height: context.w(42),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.w(21)),
              child: Image.asset(
                'assets/images/temple_logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.temple_hindu,
                  color: AppTheme.primaryColor,
                  size: context.w(24),
                ),
              ),
            ),
          ),
          SizedBox(width: context.w(12)),
          Text(
            'Jai Shree Hanuman',
            style: GoogleFonts.newsreader(
              fontSize: context.sp(20),
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: AppTheme.primaryColor,
              size: context.w(26),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── SEARCH BAR ─────────────────
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(12),
      ),
      child: Container(
        height: context.h(50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.w(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Aarti, events...',
            hintStyle: GoogleFonts.newsreader(
              color: AppTheme.textMuted,
              fontSize: context.sp(14),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppTheme.textMuted,
              size: context.w(20),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: context.h(12)),
          ),
        ),
      ),
    );
  }

  // ───────────────── HERO BANNER ─────────────────
  Widget _buildHeroBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LiveDarshanScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.w(16)),
        height: context.h(280),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.w(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.w(24)),
          child: Stack(
            children: [
              // Hanuman Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/hanuman_hero.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(180)],
                    ),
                  ),
                ),
              ),

              // LIVE DARSHAN badge
              Positioned(
                top: context.h(16),
                left: context.w(16),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w(12),
                    vertical: context.h(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withAlpha(204),
                    borderRadius: BorderRadius.circular(context.w(10)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PulsingDot(),
                      SizedBox(width: context.w(6)),
                      Text(
                        'LIVE DARSHAN',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Center text and date
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: context.h(100)),
                    Text(
                      'जय श्री हनुमान',
                      style: GoogleFonts.newsreader(
                        color: Colors.white,
                        fontSize: context.sp(36),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(color: Colors.black, blurRadius: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: context.h(8)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.w(12),
                        vertical: context.h(4),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(102),
                        borderRadius: BorderRadius.circular(context.w(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: context.w(12),
                          ),
                          SizedBox(width: context.w(8)),
                          Text(
                            _formattedDate(),
                            style: GoogleFonts.newsreader(
                              color: Colors.white,
                              fontSize: context.sp(14),
                              fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  // ───────────────── STATUS CARD ─────────────────
  Widget _buildStatusCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w(16)),
      padding: EdgeInsets.all(context.w(18)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: context.w(10),
                      height: context.w(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: context.w(10)),
                    Text(
                      'Temple is Open',
                      style: GoogleFonts.newsreader(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.h(6)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w(12),
                    vertical: context.h(8),
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(context.w(20)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: AppTheme.primaryColor,
                        size: context.w(16),
                      ),
                      SizedBox(width: context.w(6)),
                      Text(
                        'Next Aarti: Rajbhog in ',
                        style: GoogleFonts.newsreader(
                          fontSize: context.sp(12),
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        '2h 15m',
                        style: GoogleFonts.newsreader(
                          fontSize: context.sp(12),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: context.w(54),
            height: context.w(54),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withAlpha(51),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.temple_hindu_rounded,
              color: AppTheme.primaryColor,
              size: context.w(28),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── QUICK LINKS GRID ─────────────────
  Widget _buildQuickLinksGrid(BuildContext context) {
    final List<Map<String, dynamic>> links = [
      {
        'title': 'Aarti Timings',
        'icon': Icons.access_alarm,
        'color': const Color(0xFFFF7043),
        'dest': const TimingsScreen(),
      },
      {
        'title': 'Events',
        'icon': Icons.event_note,
        'color': const Color(0xFFFFB300),
        'dest': const EventsScreen(),
      },
      {
        'title': 'Gallery',
        'icon': Icons.collections,
        'color': const Color(0xFFE91E63),
        'dest': const GalleryScreen(),
      },
      {
        'title': 'Donate',
        'icon': Icons.volunteer_activism,
        'color': const Color(0xFFD32F2F),
        'dest': const DonationScreen(),
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: context.w(16),
          mainAxisSpacing: context.h(16),
          childAspectRatio: 1.4,
        ),
        itemCount: links.length,
        itemBuilder: (context, index) {
          final link = links[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => link['dest']),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.w(16)),
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(5),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(context.w(10)),
                    decoration: BoxDecoration(
                      color: (link['color'] as Color).withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      link['icon'],
                      color: link['color'],
                      size: context.w(24),
                    ),
                  ),
                  SizedBox(height: context.h(10)),
                  Text(
                    link['title'],
                    style: GoogleFonts.newsreader(
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ───────────────── TODAY'S SCHEDULE ─────────────────
  Widget _buildTodaysSchedule(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Schedule",
                style: GoogleFonts.newsreader(
                  fontSize: context.sp(20),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TimingsScreen()),
                ),
                child: Text(
                  'View All',
                  style: GoogleFonts.newsreader(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.h(8)),
        _buildScheduleItem(
          context,
          'Mangla Aarti',
          'Morning Darshan',
          '5:30 AM',
          'DONE',
          Icons.wb_twilight,
          isDone: true,
        ),
        _buildScheduleItem(
          context,
          'Shringar Aarti',
          'Deity Adornment',
          '8:00 AM',
          'DONE',
          Icons.wb_sunny_outlined,
          isDone: true,
        ),
        _buildScheduleItem(
          context,
          'Rajbhog Aarti',
          'Mid-day Offering',
          '12:00 PM',
          'UP NEXT',
          Icons.restaurant_menu,
          isNext: true,
        ),
      ],
    );
  }

  Widget _buildScheduleItem(
    BuildContext context,
    String title,
    String subTitle,
    String time,
    String status,
    IconData icon, {
    bool isDone = false,
    bool isNext = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(6),
      ),
      padding: EdgeInsets.all(context.w(14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.w(16)),
        border: Border.all(
          color: isNext ? AppTheme.primaryColor : Colors.grey.shade100,
          width: isNext ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isNext ? 10 : 5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.w(10)),
            decoration: BoxDecoration(
              color: isNext
                  ? AppTheme.primaryColor.withAlpha(20)
                  : Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isNext ? AppTheme.primaryColor : Colors.grey,
              size: context.w(20),
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.newsreader(
                    fontSize: context.sp(16),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                Text(
                  subTitle,
                  style: GoogleFonts.newsreader(
                    fontSize: context.sp(12),
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: GoogleFonts.newsreader(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: context.sp(10),
                  fontWeight: FontWeight.bold,
                  color: isNext ? AppTheme.primaryColor : Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ───────────────── UPCOMING EVENTS ─────────────────
  Widget _buildUpcomingEvents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Text(
            "Upcoming Events",
            style: GoogleFonts.newsreader(
              fontSize: context.sp(20),
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
        ),
        SizedBox(height: context.h(12)),
        SizedBox(
          height: context.h(220),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: context.w(16)),
            children: [
              _buildEventCard(
                context,
                'Sharad Purnima Utsav',
                'Oct 28 • 6 PM',
                'Special bhajan sandhya and mahaprasad distribution.',
                Icons.nights_stay,
              ),
              _buildEventCard(
                context,
                'Sundarkand Path',
                'Every Tuesday',
                'Join the weekly collective chanting of Sundarkand.',
                Icons.menu_book,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String title,
    String date,
    String desc,
    IconData icon,
  ) {
    return Container(
      width: context.w(260),
      margin: EdgeInsets.only(right: context.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.w(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.w(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.h(110),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withAlpha(150),
                    AppTheme.primaryDeep,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      icon,
                      color: Colors.white.withAlpha(50),
                      size: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        date,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.newsreader(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.newsreader(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────── TEMPLE INFO ─────────────────
  Widget _buildTempleInfoCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w(16)),
      padding: EdgeInsets.all(context.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.w(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temple Info',
            style: GoogleFonts.newsreader(
              fontSize: context.sp(20),
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          SizedBox(height: context.h(16)),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppTheme.primaryColor,
                size: context.w(22),
              ),
              SizedBox(width: context.w(12)),
              Expanded(
                child: Text(
                  'Sakariya, Gujarat\nIndia',
                  style: GoogleFonts.newsreader(
                    fontSize: context.sp(14),
                    color: AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(12)),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: AppTheme.primaryColor,
                size: context.w(22),
              ),
              SizedBox(width: context.w(12)),
              Text(
                '+91 97279 05010',
                style: GoogleFonts.newsreader(
                  fontSize: context.sp(14),
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(24)),
          SizedBox(
            width: double.infinity,
            height: context.h(54),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactScreen()),
              ),
              icon: const Icon(Icons.directions, color: Colors.white),
              label: Text(
                'Get Directions',
                style: GoogleFonts.newsreader(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w(16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
