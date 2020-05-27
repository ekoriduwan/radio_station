import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlayingStatus {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
  }

  Color get icon => _isPlaying ? Colors.lightBlue : Colors.amber;
}
