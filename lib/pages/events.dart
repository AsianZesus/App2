import 'package:flutter/material.dart';
import 'package:flood_app/pages/dash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, String>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];

    for (int i = 0; i < notifications.length; i += 3) {
      final title = notifications[i];
      final dateTimeTimestamp =
          int.tryParse(notifications[i + 2] ?? ''); // Parse as integer

      if (dateTimeTimestamp != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(
            dateTimeTimestamp * 1000); // Convert to DateTime

        setState(() {
          _notifications.add({
            'title': title,
            'dateTime': dateTime
                .toIso8601String(), // Convert DateTime to ISO 8601 String
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reverse the order of _notifications list to show newest notifications at the top
    final reversedNotifications = _notifications.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Alerts"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: reversedNotifications.length,
        itemBuilder: (context, index) {
          final notification = reversedNotifications[index];
          final title = notification['title'] ?? '';
          final dateTime = notification['dateTime'] ?? '';

          // Split the dateTime string into date and time
          final dateAndTime = dateTime.split(' ');
          final date = dateAndTime.isNotEmpty ? dateAndTime[0] : '';
          final time = dateAndTime.length >= 2 ? dateAndTime[1] : '';

          return ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date),
                Text(time),
              ],
            ),
          );
        },
      ),
    );
  }
}
