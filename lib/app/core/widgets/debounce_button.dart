import 'dart:async';

import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DebounceButton extends StatefulWidget {
  final String _text;
  final VoidCallback _onPressed;
  final Duration _duration;
  DebounceButton(
      {super.key,
      required String text,
      required VoidCallback onPressed,
      int debounceTimeMs = 200})
      : _text = text,
        _onPressed = onPressed,
        _duration = Duration(milliseconds: debounceTimeMs);

  @override
  State<DebounceButton> createState() => _DebounceButtonState();
}

class _DebounceButtonState extends State<DebounceButton> {
  late ValueSignal<bool> _isEnabled;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _isEnabled = ValueSignal<bool>(true);
    _timer = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _onButtonPressed() {
    _isEnabled.value = false;
    widget._onPressed();
    _timer = Timer(widget._duration, () => _isEnabled.value = true);
  }

  @override
  Widget build(BuildContext context) {
    return Watch.builder(builder: (context) {
      return ElevatedButton(
        onPressed: _isEnabled.value ? _onButtonPressed : null,
        child: Text(widget._text),
      );
    });
  }
}
