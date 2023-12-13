import 'package:flutter/foundation.dart';
import 'dart:async';

/// Debouncer class
///  final _debouncer = Debouncer(milliseconds: your time);
/// _debouncer.run(() { your function });

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
