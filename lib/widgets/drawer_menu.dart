import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final ValueChanged<String> onItemSelected;

  const DrawerMenu({
    super.key,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("John Doe"),
            accountEmail: const Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "JD",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 24,
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade800,
                  Colors.blueAccent.shade400,
                ],
              ),
            ),
          ),
          _buildMenuItem(Icons.home, "Home", "home"),
          _buildMenuItem(Icons.person, "Profile", "profile"),
          _buildMenuItem(Icons.settings, "Settings", "settings"),
          const Divider(),
          _buildMenuItem(Icons.logout, "Logout", "logout"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade800),
      title: Text(title),
      onTap: () => onItemSelected(value),
    );
  }
}
