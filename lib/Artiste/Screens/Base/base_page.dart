import 'package:flutter/material.dart';
import 'package:imisi/Utils/gap.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("sjdsdc  sdiochs iduchs"),
          Text("sjdsdc  sdiochs iduchs"),
        ],
      ),
    );
  }
}
