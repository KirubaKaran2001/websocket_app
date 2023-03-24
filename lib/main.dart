import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:websocket_app/screens/main_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        channel: IOWebSocketChannel.connect(
          Uri.parse('wss://echo.websocket.events'),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
