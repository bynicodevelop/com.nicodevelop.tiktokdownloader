import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ClipboardComponent extends StatefulWidget {
  final Widget child;
  final Function(String)? onClipboardChanged;

  const ClipboardComponent({
    Key? key,
    required this.child,
    this.onClipboardChanged,
  }) : super(key: key);

  @override
  State<ClipboardComponent> createState() => _ClipboardComponentState();
}

class _ClipboardComponentState extends State<ClipboardComponent>
    with WidgetsBindingObserver {
  void _sendUrlFromClipboard() {
    FlutterClipboard.paste().then((value) {
      if (value.isNotEmpty) {
        if (widget.onClipboardChanged != null) {
          widget.onClipboardChanged!(value);
        }

        FlutterClipboard.copy("null").then(
          (value) => log("Clipboard cleared"),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _sendUrlFromClipboard();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    if (appLifecycleState == AppLifecycleState.resumed) {
      _sendUrlFromClipboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
