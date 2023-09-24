import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stack Page'),
          backgroundColor: const Color.fromARGB(255, 165, 182, 190),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  color: Colors.red,
                ),
                Positioned(
                  top: 500,
                  left: 300,
                  child: Container(
                    height: 200,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Item $index"),
                  );
                },
              ),
            )
          ],
        ));
  }
}
