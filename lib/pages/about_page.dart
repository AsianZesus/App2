import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Text(
                  '''\nWelcome to our Flood Alert App, your reliable companion in flood monitoring and preparedness. Our app utilizes cutting-edge technology to gather real-time data from sensors strategically placed in flood-prone areas. Stay informed and secure with timely notification alerts, ensuring you receive critical flood updates and warnings to keep you and your loved ones safe. \nOur commitment to your safety extends beyond just flood monitoring. 
                  \nJoin us in our mission to harness technology for better flood monitoring and response. Together, let's build a flood-resilient future where communities are better equipped to face flood challenges with confidence and preparedness. ''',
                  style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
