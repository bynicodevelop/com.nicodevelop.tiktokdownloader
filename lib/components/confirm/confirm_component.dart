import 'package:flutter/material.dart';

class ConfirmComponent extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Function()? onCancel;
  final Function()? onConfirm;

  const ConfirmComponent({
    super.key,
    required this.title,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
