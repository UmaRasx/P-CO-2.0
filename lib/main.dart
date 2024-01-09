import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThingSpeak Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/gasPage': (context) => const GasPage(),
        '/settingsPage': (context) => const SettingsPage(),
        '/carbonMonoxidePage': (context) => const CarbonMonoxidePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to P-CO Menu',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gasPage');
              },
              child: const Text('Go to CO Gas Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settingsPage');
              },
              child: const Text('Go to ThingSpeak'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/carbonMonoxidePage');
              },
              child: const Text('Go to Carbon Monoxide Concentrations'),
            ),
          ],
        ),
      ),
    );
  }
}

class GasPage extends StatefulWidget {
  const GasPage({super.key});

  @override
  _GasPageState createState() => _GasPageState();
}

class _GasPageState extends State<GasPage> {
  final String apiKey = "JNG4L3C9Y984B7JH";
  final int fieldNumber = 1;
  final String serverURL =
      "https://api.thingspeak.com/channels/2189706/feeds.json?api_key=JNG4L3C9Y984B7JH&results=1";

  String responseText = '';

  @override
  void initState() {
    super.initState();
    fetchDataFromThingSpeak().then((value) {
      setState(() {
        responseText = value;
      });
    });
  }

  Future<String> fetchDataFromThingSpeak() async {
    final response = await http.get(Uri.parse(serverURL));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final feeds = jsonData['feeds'];

      if (feeds.isNotEmpty) {
        final feed = feeds[0];
        final value = feed['field$fieldNumber'];

        return value.toString();
      }
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Latest CO Gas% update Page',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(responseText),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final String thingSpeakURL = 'https://thingspeak.com/channels/2189706';

  const SettingsPage({super.key});

  void _launchThingSpeakURL() async {
    if (await canLaunch(thingSpeakURL)) {
      await launch(thingSpeakURL);
    } else {
      throw 'Could not launch $thingSpeakURL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Settings Page',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchThingSpeakURL,
              child: const Text('Go to ThingSpeak'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class CarbonMonoxidePage extends StatelessWidget {
  final String carbonMonoxideURL =
      'https://www.abe.iastate.edu/extension-and-outreach/carbon-monoxide-concentrations-table-aen-172/';

  const CarbonMonoxidePage({super.key});

  void _launchCarbonMonoxideURL() async {
    if (await canLaunch(carbonMonoxideURL)) {
      await launch(carbonMonoxideURL);
    } else {
      throw 'Could not launch $carbonMonoxideURL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Monoxide Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Carbon Monoxide Concentrations',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
            const SizedBox(height: 20),
            CarbonMonoxidePageText(), // Include the new widget here
          ],
        ),
      ),
    );
  }
}

class CarbonMonoxidePageText extends StatelessWidget {
  const CarbonMonoxidePageText({Key? key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
            text: 'Carbon monoxide (CO) is a colorless, odorless gas that highly toxic gas.\n'
                'and exposure to elevated levels of carbon monoxide can be dangerous and even fatal.\n\n'
                'The concentration of carbon monoxide in the air is typically measured in parts per million (ppm).\n\n'
                'The following are general guidelines for carbon monoxide levels:\n\n',
          ),
          TextSpan(
            text: '1. Low Levels (0-9 ppm): ',
            style: TextStyle(color: Colors.green),
          ),
          TextSpan(
            text: 'this Exposure is Normal.\n\n',
          ),
          TextSpan(
            text: '2. Medium Levels (10-35 ppm): ',
            style: TextStyle(color: Colors.yellow),
          ),
          TextSpan(
            text: 'Exposure to medium levels may cause headaches and dizziness. Prolonged exposure can be harmful.\n\n',
          ),
          TextSpan(
            text: '3. High Levels (36-99 ppm): ',
            style: TextStyle(color: Colors.orange),
          ),
          TextSpan(
            text: 'Exposure to these levels, symptoms become more severe, and individuals may experience nausea, confusion, and a risk of long-term health effects.\n\n',
          ),
          TextSpan(
            text: '4. Very High Levels (100+ ppm): ',
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(
            text: 'Exposure to very high levels of carbon monoxide can be life-threatening and may lead to loss of consciousness, coma, and death.\n\n',
          ),
        ],
      ),
    );
  }
}