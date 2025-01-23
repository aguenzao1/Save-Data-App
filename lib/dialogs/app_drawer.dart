import 'package:flutter/material.dart';
import '../screens/home/home_page.dart';

class AppDrawer extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const AppDrawer({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            DrawerHeader(
              child: SizedBox(
                height: 150.0,
                width: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/mrclogo.png",
                      height: 98.0,
                      width: 98.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "CAIDAT MANAGER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomePage(
                        toggleTheme: toggleTheme,
                        isDarkMode: isDarkMode,
                      ),
                      transitionDuration: const Duration(milliseconds: 700),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.home, size: 25.0),
                label: const Text(
                  'HOME',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton.icon(
                onPressed: () => toggleTheme(),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(12),
                ),
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 25.0,
                ),
                label: Text(
                  isDarkMode ? 'Light Mode' : 'Dark Mode',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}