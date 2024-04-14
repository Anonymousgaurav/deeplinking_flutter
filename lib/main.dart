import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Method channel
  static const platform = MethodChannel('launchUrl');

  // Method to open URL
  static Future<void> openUrl(String url) async {
    try {
      await platform.invokeMethod('openUrl', url);
    } on PlatformException catch (e) {
      print("Failed to open URL: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Platform-Specific URL Launching")),
        body: Center(
          child: TextButton(
            onPressed: () {
              openUrl('https://www.youtube.com/@aajtak');
            },
            child: Text('Open URL'),
          ),
        ),
      ),
    );
  }
}
