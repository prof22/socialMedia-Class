import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/navigationbarProvider.dart';
import 'package:social_media_app/views/friends/friendScreen.dart';
import 'package:social_media_app/views/homescreen/home_feeds.dart';
import 'package:social_media_app/views/homescreen/post/createNewPost.dart';
import 'package:social_media_app/views/profile/profileScreen.dart';
import 'package:social_media_app/views/settings/settingScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationbarProvider = Provider.of<Navigationbarprovider>(context);
    final theme = Theme.of(context);
    final pages = [
      HomeFeedScreen(),
      const Friendscreen(),
      const ProfileScreen(),
      const SettingScreen()
    ];
    final titles = [
      'Feeds',
      'Friends List',
      'Profile',
      'Settings',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        title: Text(
          titles[navigationbarProvider.currentIndex],
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: pages[navigationbarProvider.currentIndex]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostCreationScreen()));
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: BottomNavigationBar(
          currentIndex: navigationbarProvider.currentIndex,
          onTap: (index) => navigationbarProvider.setIndex(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
