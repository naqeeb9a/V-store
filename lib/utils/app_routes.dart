import 'package:flutter/material.dart';

class KRoutes {
  void push(context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void pop(context) {
    Navigator.pop(context);
  }

  void pushAndRemoveUntil(context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => page,
        ),
        (Route<dynamic> route) => false);
  }

  void popUntil(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
