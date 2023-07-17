import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flood_app/components/drawer.dart';
import 'package:flood_app/main.dart';
import 'package:flood_app/pages/about_page.dart';
import 'package:flood_app/widgets/sensor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DashPage extends StatefulWidget {
  const DashPage({super.key});

  static const route = '/dash-page';

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  void showNotificatinons() async{
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "notificaitons-flood", "Flood Notifications",
        priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails
    );

    await notificationsPlugin.show(0, "Flood Alert", "This is a test", notiDetails);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FLOOD  ALERT"),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(
        onAboutTap: goToAboutPage,
        onLogOutTap: signOut,
      ),
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
                        assetImage: const AssetImage('assets/images/water.png'),
                        unit: 'l/m',
                        trendData: waterList!,
                        linePoint: Colors.blueAccent),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
