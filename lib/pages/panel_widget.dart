import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/warning.png'),
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Information on alerts',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      '''The flood alerts are issued as a result of river levels exceeding the thresholds put on the sensors.\n \nPlease follow instructions given below to know what to do when an alert is issued.''',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '''\nFirst and foremost, contact the relevant or local authorities. The nationwide toll free number "1155" can be dialed to clear any queries regarding flood related information you need.''',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '''\nEvacuation Recommended: If you reside in a flood-prone area near the river or low-lying regions, it is strongly advised to evacuate immediately. Take only essential belongings and move to higher ground or designated evacuation centers.
                    \nMonitor Emergency Channels: Keep your radio or television tuned to local news for real-time updates on the flood situation, evacuation routes, and emergency contact information. 
                    \nNotify Neighbors: Inform your neighbors about the flood alert to ensure everyone in the community is aware and can take necessary actions. 
                    \nSecure Your Property: If time allows, secure your property by moving valuables to higher floors, shutting off utilities, and unplugging electrical appliances. 
                    \nEmergency Kit: Grab your emergency kit, which should include food, water, first-aid supplies, flashlight, batteries, important documents, and any necessary medications. 
                    \nAvoid Floodwater: Stay away from floodwater and avoid walking or driving through flooded roads. The water may be deeper and swifter than it appears, posing life-threatening risks. 
                    \nStay in Communication: Inform friends or family members outside the affected area about your situation, and provide them with your whereabouts.''',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
}
