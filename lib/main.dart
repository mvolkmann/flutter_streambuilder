import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

const title = 'My App';

void main() => runApp(
      MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Home(),
      ),
    );

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const initialTemperature = 50.0;
  late Stream stream; // of temperature values

  @override
  void initState() {
    super.initState();

    var temperature = initialTemperature;
    final random = Random();
    // Every second randomly change the temperature.
    stream = Stream.periodic(Duration(seconds: 1), (_) {
      final up = random.nextBool();
      final delta = random.nextDouble(); // 0 <= delta < 1
      temperature += up ? delta : -delta;
      return temperature.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              initialData: initialTemperature,
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('error: ${snapshot.error}');
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Text('current temperature: ${snapshot.data}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
