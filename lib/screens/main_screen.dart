import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  final WebSocketChannel channel;
  const HomeScreen({super.key, required this.channel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket',),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: sendData,
          child: const Icon(
            Icons.send,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the message',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(snapshot.data.toString()),
                  );
                } else {
                  return const Text('Connect server');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  sendData() {
    if (controller.text.isNotEmpty) {
      widget.channel.sink.add(controller.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
