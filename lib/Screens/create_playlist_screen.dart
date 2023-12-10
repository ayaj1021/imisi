import 'package:flutter/material.dart';

class CreatePlayListScreen extends StatefulWidget {
  const CreatePlayListScreen({super.key});

  @override
  State<CreatePlayListScreen> createState() => _CreatePlayListScreenState();
}

class _CreatePlayListScreenState extends State<CreatePlayListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Give your playlist a name'),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Create your playlist',),
            )
          ],
        ),
      )),
    );
  }
}
