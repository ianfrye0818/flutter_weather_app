import 'package:flutter/material.dart';

class ErrorSnackBar {
  const ErrorSnackBar({this.city});
  final String? city;

  SnackBar buildSnackBar(BuildContext context) {
    return SnackBar(
      dismissDirection: DismissDirection.down,
      closeIconColor: Colors.white,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: city != null
          ? Text(
              'Was unable to locate $city, Please try again.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            )
          : const Text('Something went wrong, Please try again'),
    );
  }
}
