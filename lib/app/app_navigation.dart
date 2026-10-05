import 'package:flutter/material.dart';
import '../screens/my_replies_screen.dart';
import '../screens/chat_screen.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  // ============================================================
  // CURRENT SELECTED TAB
  // ============================================================

  int _selectedIndex = 0;

  // ============================================================
  // SCREENS
  //
  // Replace the placeholder widgets with your actual screens.
  // ============================================================

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      // ========================================================
      // 0 - HOME
      // ========================================================
      const PlaceholderScreen(title: 'Home'),

      // ========================================================
      // 1 - COMMUNITY
      // ========================================================
      const PlaceholderScreen(title: 'Community'),

      // ========================================================
      // 2 - MY REPLIES
      // ========================================================
      MyRepliesScreen(
        onDiscussionTap: (discussionId) {
          // Put your discussion navigation here later.
          //
          // Example:
          //
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         DiscussionDetailsScreen(
          //           discussionId: discussionId,
          //         ),
          //   ),
          // );
        },
      ),

      // ========================================================
      // 3 - CHAT
      // ========================================================
      const ChatScreen(),

      // ========================================================
      // 4 - PROFILE
      // ========================================================
      const PlaceholderScreen(title: 'Profile'),
    ];
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================
      // CURRENT SCREEN
      // ========================================================
      body: IndexedStack(index: _selectedIndex, children: _screens),

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: const [
          // ====================================================
          // HOME
          // ====================================================
          NavigationDestination(
            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: 'Home',
          ),

          // ====================================================
          // COMMUNITY
          // ====================================================
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),

            selectedIcon: Icon(Icons.groups),

            label: 'Community',
          ),

          // ====================================================
          // REPLIES
          // ====================================================
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),

            selectedIcon: Icon(Icons.chat_bubble),

            label: 'Replies',
          ),

          // ====================================================
          // CHAT
          // ====================================================
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),

            selectedIcon: Icon(Icons.forum),

            label: 'Chat',
          ),

          // ====================================================
          // PROFILE
          // ====================================================
          NavigationDestination(
            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// PLACEHOLDER SCREEN
//
// You can replace this widget with your actual screen later.
// ==================================================================

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$title Screen',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
