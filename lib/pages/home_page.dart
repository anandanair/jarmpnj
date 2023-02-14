import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jarmpnj/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  // Check for permissions and return bool
  Future<bool> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.locationWhenInUse,
      Permission.notification,
      Permission.videos,
      Permission.photos,
      Permission.audio,
    ].request();
    bool allGranted = true;
    statuses.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allGranted = false;
      }
    });
    return allGranted;
  }

  // Request permissions and redirect
  void requestPermissions() async {
    bool allGranted = await checkPermissions();
    if (allGranted) {
      // Route to the Home Page
    }
  }

  // Toggle Bottom Navigation Pages
  void toggleBottomNavigationPages(index) {
    switch (index) {
      case 0:
        // Photos Page
        break;
      case 1:
        // Search Page
        break;
      case 2:
        // Favorites Page
        break;
      case 3:
        // Settings Page
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Theme.of(context).colorScheme.background,
            color: Theme.of(context).colorScheme.primary,
            activeColor: Theme.of(context).colorScheme.primary,
            tabBackgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(50),
            padding: const EdgeInsets.all(16),
            gap: 8,
            haptic: true,
            onTabChange: toggleBottomNavigationPages,
            tabs: const [
              GButton(
                icon: Icons.photo,
                text: 'Photos',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Favorites',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
