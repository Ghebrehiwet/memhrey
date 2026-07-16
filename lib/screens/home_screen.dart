// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/progress_provider.dart';
import '../widgets/widgets.dart';
import 'level1/level1_screen.dart';
import 'level2/level2_screen.dart';
import 'level3/level3_screen.dart';
import 'level4/level4_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      body: IndexedStack(
        index: _tab,
        children: [
          _buildHomeTab(progress),
          _buildAchievementsTab(progress),
          _buildSettingsTab(progress),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'መበገሲ - Home'),
          NavigationDestination(icon: Icon(Icons.emoji_events_rounded), label: 'ዓወታት - Achievements'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: ' መቓናት - Settings'),
        ],
      ),
    );
  }

  Widget _buildHomeTab(ProgressProvider progress) {
    // Guard: show loading spinner until levels are populated
    if (progress.levels.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF7C4DFF)),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 180,
          floating: false,
          pinned: true,
          backgroundColor: const Color(0xFF5C6BC0),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3949AB), Color(0xFF7C4DFF)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ሰላም${progress.studentName.isNotEmpty ? ", ${progress.studentName}" : ""}! 👋',
                        style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      const Text('ንኺድ ... ጉዕዞ ትምህርቲ ትግርኛ ንቐጽል!',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          StatBadge(icon: Icons.bolt, value: '${progress.totalXP}', label: 'XP', color: Colors.amber),
                          const SizedBox(width: 10),
                          StatBadge(icon: Icons.local_fire_department, value: '${progress.streak}', label: 'Streak', color: Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 8),
            child: Text('ናይ ትምህርቲ ደርጃታት', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              if (i >= progress.levels.length) return const SizedBox.shrink();
              final level = progress.levels[i];
              return LevelCard(
                level: level,
                onTap: () => _navigateToLevel(context, i + 1),
              ).animate().slideX(begin: -0.2, delay: (i * 100).ms, duration: 400.ms);
            },
            childCount: progress.levels.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  void _navigateToLevel(BuildContext context, int level) {
    Widget screen;
    switch (level) {
      case 1: screen = const Level1Screen(); break;
      case 2: screen = const Level2Screen(); break;
      case 3: screen = const Level3Screen(); break;
      case 4: screen = const Level4Screen(); break;
      default: return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Widget _buildAchievementsTab(ProgressProvider progress) {
    final all = ['level1_complete', 'level2_complete', 'level3_complete', 'all_levels_complete',
                  'xp_100', 'xp_500', 'xp_1000'];
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: AppBar(title: const Text('Achievements'), backgroundColor: const Color(0xFF5C6BC0), foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: all.length,
        itemBuilder: (_, i) => AchieveTile(
          id: all[i],
          unlocked: progress.achievements.contains(all[i]),
        ).animate().slideX(begin: 0.2, delay: (i * 80).ms, duration: 300.ms),
      ),
    );
  }

  Widget _buildSettingsTab(ProgressProvider progress) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2FF),
      appBar: AppBar(title: const Text('Settings'), backgroundColor: const Color(0xFF5C6BC0), foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF5C6BC0)),
            title: const Text('ስም ተማሃራይ - Student Name'),
            subtitle: Text(progress.studentName.isEmpty ? 'Not set' : progress.studentName),
            trailing: const Icon(Icons.edit),
            onTap: () => _showNameDialog(progress),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white,
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.refresh, color: Colors.orange),
            title: const Text('ኩሉ ዝሰራሕካዮ ደምስሶ - Reset All Progress'),
            subtitle: const Text('ናይ ትምህርቲ ጉዕዞ ጀምር - Start the learning journey over'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showResetDialog(progress),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white,
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF5C6BC0)),
            title: const Text('ብዛዕባ እዛ ኣፕ - About'),
            subtitle: const Text('Tigrigna Learning App v1.0.0 \n Developed by Ghebrehiwet Berhane \n Contact: techbrhan@gmail.com \n Features: Learn Tigrigna through reading, writing, listening, gaming, quizzes, and achievements!'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void _showNameDialog(ProgressProvider progress) {
    final ctrl = TextEditingController(text: progress.studentName);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ስም ተማሃራይ - Student Name'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'ስምካ ጻሓፍ - Enter your name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ደምስስ - Cancel')),
          ElevatedButton(
            onPressed: () {
              progress.setStudentName(ctrl.text.trim());
              Navigator.pop(context);
            },
            child: const Text('ዓቅብ - Save'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(ProgressProvider progress) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ኩሉ ዝሰራሕካዮ ክትድምስሶ ትደልዩ፧ - Reset All Progress?'),
        content: const Text('ኩሉ ዝሰራሕክምዎ ንሓዋሩ ክጠፍእ እዩ። ርግጸኛ ዲኹም፧ - All your progress will be permanently lost. Are you sure?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ኣይትደምስስ - Cancel')),
          ElevatedButton(
            onPressed: () {
              progress.resetAll();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('ደምስስ - Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}