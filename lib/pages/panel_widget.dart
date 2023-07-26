import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;

  const PanelWidget({
    super.key,
    required this.controller,
  });

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  final Query dbRef = FirebaseDatabase.instance.ref().child('HC');
  final Query dbRefTwo = FirebaseDatabase.instance.ref().child('YF');

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
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
                Column(
                  children: [
                    
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
