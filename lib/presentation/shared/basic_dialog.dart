import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String text;
  final Function? onConfirm;
  final Function? onCancel;

  const BasicDialog(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.title,
      required this.text,
      this.onConfirm,
      this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 48,
            color: iconColor,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        if (onCancel != null)
          TextButton(
            onPressed: () {
              onCancel?.call();
            },
            child: const Text('Cancel'),
          ),
        TextButton(
          onPressed: () {
            onConfirm?.call();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
