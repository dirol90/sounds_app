import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sounds_app/screen/screen_player.dart';
import 'package:sounds_app/screen/screen_selected_soundes.dart';
import 'package:sounds_app/screen/screen_settings.dart';
import 'package:sounds_app/screen/screen_sounds.dart';

import 'destinations.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.destination.path == PlayerScreen.routName) {
      return PlayerScreen();
    } else if (widget.destination.path == SettingsScreen.routName) {
      return SettingsScreen();
    } else if (widget.destination.path == SoundsScreen.routName) {
      return SoundsScreen();
    }

  }
}
