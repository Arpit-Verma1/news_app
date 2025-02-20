import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override


  bool isNotificationEnabled = true;
  bool isSocialMediaEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://upload.wikimedia.org/wikipedia/en/7/76/Joker_%282019_film%29_poster.jpg', // Replace with actual URL
                    ),
                  ),
                  SizedBox(width: 12),
                  // Name & Bio
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TheAlphamerc",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Loyal Reader",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat("826", "Followers"),
                  _buildStat("251", "Following"),
                  _buildStat("81K", "News Read"),
                ],
              ),
            ),

            SizedBox(height: 20),
            Divider(),

            // Settings List
            _buildSwitchTile(Icons.lightbulb_outline, "Night", themeProvider.isDarkMode,
                (value) {
              themeProvider.toggleTheme();
            }),

            _buildSwitchTile(
                Icons.notifications_none, "Notification", isNotificationEnabled,
                (value) {
              setState(() => isNotificationEnabled = value);
            }),

            _buildSwitchTile(Icons.share, "Social Media", isSocialMediaEnabled,
                (value) {
              setState(() => isSocialMediaEnabled = value);
            }),

            SizedBox(height: 20),
            Divider(),

            // Logout Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextButton.icon(
                onPressed: () {
                  // Logout logic here
                },
                icon: Icon(Icons.logout, color: Colors.red),
                label: Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Stats
  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(number,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  // Helper Widget for Switch List Tiles
  Widget _buildSwitchTile(
      IconData icon, String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      secondary: Icon(icon, color: Colors.black54),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.purple,

    );
  }
}
