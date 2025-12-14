import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -------------------------
              /// PROFILE HEADER
              /// -------------------------
              Center(
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppTheme.accent,
                      child: Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Demo User",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "demo@iot.app",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// -------------------------
              /// ACCOUNT INFORMATION
              /// -------------------------
              const Text(
                "Account Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              _infoTile(
                icon: Icons.phone,
                title: "Phone Number",
                value: "+91 9XXXXXXXXX",
              ),

              _infoTile(
                icon: Icons.location_on,
                title: "Default Address",
                value: "123, Main Street, Bangalore",
              ),

              _infoTile(
                icon: Icons.verified_user,
                title: "Account Status",
                value: "Verified",
              ),

              const SizedBox(height: 24),

              /// -------------------------
              /// APP SETTINGS
              /// -------------------------
              const Text(
                "Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              _actionTile(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () {
                  // UI only for now
                },
              ),

              _actionTile(
                icon: Icons.lock,
                title: "Change Password",
                onTap: () {},
              ),

              _actionTile(
                icon: Icons.notifications,
                title: "Notification Settings",
                onTap: () {},
              ),

              const SizedBox(height: 30),

              /// -------------------------
              /// LOGOUT BUTTON
              /// -------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    // TODO: logout logic later
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// -------------------------
  /// INFO TILE
  /// -------------------------
  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// -------------------------
  /// ACTION TILE
  /// -------------------------
  Widget _actionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppTheme.accent),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
