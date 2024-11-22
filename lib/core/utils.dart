import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}

enum NavigationType { push, pushReplacement, pop, pushAndRemoveUntil }

void navigate({
  required BuildContext context,
  required Widget screen,
  NavigationType type = NavigationType.push,
}) {
  switch (type) {
    case NavigationType.push:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
      break;
    case NavigationType.pushReplacement:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
      break;
    case NavigationType.pop:
      Navigator.pop(context);
      break;
    case NavigationType.pushAndRemoveUntil:
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen),
          (Route route) => false);
  }
}
