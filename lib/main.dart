import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'map.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/second': (context) => const SecondRoute(),
      '/third': (context) => const ThirdRoute(),
    },
  ));
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailist'),
        backgroundColor: Colors.blue,
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Register placeholder'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
            ), // ElevatedButton
            ElevatedButton(
              child: const Text('Login placeholder'),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
            ), // ElevatedButton
          ], // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: Colors.blue,
      ), // AppBar
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back!'),
        ), // ElevatedButton
      ), // Center
    ); // Scaffold
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged in"),
        backgroundColor: Colors.blue,
      ), // AppBar
      body: Center(
        child: lined_map(cords:[LatLng(35, 40), LatLng(20, 50), LatLng(25, 45)])//map(), // ElevatedButton
      ),
    ); // Scaffold
  }
}


