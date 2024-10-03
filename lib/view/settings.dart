import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings states
  bool smsNotifications = true;
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool gpsTracking = true;
  String defaultCategory = "Electrical";
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Profile Management Section
        ListTile(
          title: Text('Profile Management'),
          subtitle: Text('Update profile information'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to profile management screen
          },
        ),
        ListTile(
          title: Text('Change Password'),
          subtitle: Text('Update your password'),
          leading: Icon(Icons.lock),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to password change screen
          },
        ),
        Divider(),

        // Notification Settings
        ListTile(
          title: Text('Notifications'),
          leading: Icon(Icons.notifications),
        ),
        SwitchListTile(
          title: Text('SMS Notifications'),
          subtitle: Text('Receive SMS updates'),
          value: smsNotifications,
          onChanged: (bool value) {
            setState(() {
              smsNotifications = value;
            });
          },
        ),
        SwitchListTile(
          title: Text('Push Notifications'),
          subtitle: Text('Receive app notifications'),
          value: pushNotifications,
          onChanged: (bool value) {
            setState(() {
              pushNotifications = value;
            });
          },
        ),
        SwitchListTile(
          title: Text('Email Notifications'),
          subtitle: Text('Receive updates via email'),
          value: emailNotifications,
          onChanged: (bool value) {
            setState(() {
              emailNotifications = value;
            });
          },
        ),
        Divider(),

        // Service Preferences
        ListTile(
          title: Text('Service Preferences'),
          leading: Icon(Icons.settings),
        ),
        SwitchListTile(
          title: Text('GPS Tracking'),
          subtitle: Text('Automatically log job locations'),
          value: gpsTracking,
          onChanged: (bool value) {
            setState(() {
              gpsTracking = value;
            });
          },
        ),
        ListTile(
          title: Text('Default Service Category'),
          subtitle: Text('Preferred category for new requests'),
          trailing: DropdownButton<String>(
            value: defaultCategory,
            items: <String>['Electrical', 'Plumbing', 'IT Support']
                .map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                defaultCategory = newValue!;
              });
            },
          ),
        ),
        Divider(),

        // Language and Localization
        ListTile(
          title: Text('Language'),
          subtitle: Text('Change the app language'),
          trailing: DropdownButton<String>(
            value: selectedLanguage,
            items: <String>['English', 'French', 'Spanish']
                .map((String language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            },
          ),
        ),
        Divider(),

        // Data and Storage
        ListTile(
          title: Text('Clear Cache'),
          subtitle: Text('Free up space by clearing cached data'),
          leading: Icon(Icons.storage),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Logic to clear cache
          },
        ),
        ListTile(
          title: Text('Sync Data'),
          subtitle: Text('Manually sync data with the cloud'),
          leading: Icon(Icons.sync),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Logic to sync data
          },
        ),
        Divider(),

        // Security and Privacy
        ListTile(
          title: Text('Two-Factor Authentication'),
          subtitle: Text('Add an extra layer of security'),
          leading: Icon(Icons.security),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to 2FA setup
          },
        ),
        ListTile(
          title: Text('App Lock'),
          subtitle: Text('Set a PIN or enable fingerprint unlock'),
          leading: Icon(Icons.lock_outline),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to App Lock setup
          },
        ),
        Divider(),

        // About and Support
        ListTile(
          title: Text('App Version'),
          subtitle: Text('1.0.0'),
          leading: Icon(Icons.info_outline),
        ),
        ListTile(
          title: Text('Support & Feedback'),
          subtitle: Text('Contact support or report an issue'),
          leading: Icon(Icons.support_agent),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to support/feedback screen
          },
        ),
        ListTile(
          title: Text('About the App'),
          subtitle: Text('Learn more about this app'),
          leading: Icon(Icons.info),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Navigate to About screen
          },
        ),
      ],
    );
  }
}
