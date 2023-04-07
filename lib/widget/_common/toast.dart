import 'package:flutter/material.dart';

void showToast(BuildContext context, String message) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      return Container(
          color: Colors.grey[800],
          padding: const EdgeInsets.all(12),
          child: Wrap(alignment: WrapAlignment.center, children: [
            Text(
              message
            )
          ]));
    },
  );
}
