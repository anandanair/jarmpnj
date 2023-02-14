import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jarmpnj/pages/photos_page.dart';
import 'package:jarmpnj/services/auth.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
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

  final screens = [
    PhotosPage(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text("Search")),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text("Favorites")),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text("Settings")),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JARMPNJ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                maxRadius: 17,
                backgroundImage: NetworkImage(user!.photoURL ?? ""),
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                child: InkWell(
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
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
            onTabChange: (value) {
              setState(() {
                currentIndex = value;
              });
            },
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
