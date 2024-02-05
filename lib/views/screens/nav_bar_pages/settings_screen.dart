import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../app_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userPhone = "";

  @override
  void initState() {
    super.initState();
    getUserPhoneNumber();
  }

  Future<void> getUserPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userPhone = prefs.getString(AppSettings.emailSharedPrefsKey) ?? "--";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.5),
              ),
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "User Number:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              userPhone,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildSettingsCard(
              Icons.edit,
              "Edit Profile",
              "Manage your account",
            ),
            _buildSettingsCard(
              Icons.settings,
              "App Settings",
              "Manage your Settings",
            ),
            _buildSettingsCard(
              Icons.info,
              "About app",
              "Data about developer and application",
            ),
            _buildSettingsCard(
              Icons.exit_to_app,
              "Signout",
              "",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
