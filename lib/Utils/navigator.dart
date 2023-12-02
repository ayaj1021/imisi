import 'package:flutter/material.dart';

nextPage(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

nextPageAndremoveUntil(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
