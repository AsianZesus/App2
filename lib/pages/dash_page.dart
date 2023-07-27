import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flood_app/components/drawer.dart';
import 'package:flood_app/main.dart';
import 'package:flood_app/pages/about_page.dart';
import 'package:flood_app/pages/events.dart';
import 'package:flood_app/pages/panel_widget.dart';
import 'package:flood_app/pages/settings_page.dart';
import 'package:flood_app/widgets/sensor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashPage extends StatefulWidget {
  const DashPage({super.key});

  static const route = '/dash-page';

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  void showNotificatinons() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "notificaitons-flood",
      "Flood Notifications",
      priority: Priority.max,
      importance: Importance.max,
      styleInformation: BigTextStyleInformation(
        "The sensors have detected an unusual surge of water that surpases the normal threshold. As a result, there is a high risk of flooding in low-lying areas and near water bodies.",
      ),
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    const String symbol = '\u26A0';

    // Get the current date and time as UNIX timestamp (number of seconds since epoch)
    final now = DateTime.now();
    final notificationDateTime =
        now.millisecondsSinceEpoch ~/ 1000; // Convert to seconds

    // Store notification details in shared preferences
    final prefs = await SharedPreferences.getInstance();
    final notifications = prefs.getStringList('notifications') ?? [];
    notifications.add("Flood Alert  $symbol");
    notifications.add(
      "The sensors have detected an unusual surge of water that surpases the normal threshold. As a result, there is a high risk of flooding in low-lying areas and near water bodies.",
    );
    notifications.add(notificationDateTime.toString()); // Convert to String

    prefs.setStringList('notifications', notifications);

    // Show the notification immediately
    await notificationsPlugin.show(
      0,
      "Flood Alert  $symbol",
      "The sensors have detected an unusual surge of water that surpases the normal threshold. As a result, there is a high risk of flooding in low-lying areas and near water bodies.",
      notiDetails,
    );
  }

  final Query dbRef = FirebaseDatabase.instance.ref().child('HC');
  final Query dbRefTwo = FirebaseDatabase.instance.ref().child('YF');

  List<double>? distList;
  List<double>? waterList;

  void signOut() {
    // pop the drawer
    Navigator.pop(context);
    // logout of the app
    FirebaseAuth.instance.signOut();
  }

  void goToAboutPage() {
    // pop the app drawer
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutPage(),
      ),
    );
  }

  void onSettingsTap() {
    // pop the app drawer
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FLOOD  ALERT"),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(
        onLogOutTap: signOut,
        onSettingsTap: onSettingsTap,
      ),
      body: SlidingUpPanel(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (context, snapshot, animation, index) {
                  double distdata = double.tryParse(
                          snapshot.child('distance').value.toString()) ??
                      0.0;

                  if (distList == null) {
                    distList = List.filled(5, distdata, growable: true);
                  } else {
                    distList!.add(distdata);
                    distList!.removeAt(0);
                  }

                  if (distdata > 100) {
                    showNotificatinons();
                  }

                  return Column(
                    children: [
                      MySensorCard(
                          value: distdata,
                          name: 'Distance',
                          assetImage:
                              const AssetImage('assets/images/distance.png'),
                          unit: 'cm',
                          trendData: distList!,
                          linePoint: Colors.blueAccent),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRefTwo,
                itemBuilder: (context, snapshot, animation, index) {
                  double waterdata = double.tryParse(
                          snapshot.child('Volume').value.toString()) ??
                      0.0;

                  if (waterList == null) {
                    waterList = List.filled(5, waterdata, growable: true);
                  } else {
                    waterList!.add(waterdata);
                    waterList!.removeAt(0);
                  }

                  if (waterdata > 100) {
                    showNotificatinons();
                  }

                  return Column(
                    children: [
                      MySensorCard(
                          value: waterdata,
                          name: 'Water Flow',
                          assetImage:
                              const AssetImage('assets/images/water.png'),
                          unit: 'l/m',
                          trendData: waterList!,
                          linePoint: Colors.blueAccent),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
        minHeight: panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: .2,
        panelBuilder: (ScrollController controller) => PanelWidget(
          controller: controller,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      ),
    );
  }
}
