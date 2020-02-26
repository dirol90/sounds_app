
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sounds_app/screen/screen_player.dart';
import 'package:sounds_app/screen/screen_settings.dart';
import 'package:sounds_app/screen/screen_sounds.dart';

class Destination {
  const Destination(this.title, this.image, this.color, this.path);

  final String title;
  final Image image;
  final Color color;
  final String path;
}

List<Destination> allDestinations = <Destination>[
  Destination('Player', Image.asset('assets/images/voice_icon.png', height: 30, width: 30,), Color(0x00FFFFFF), PlayerScreen.routName),
  Destination('Sounds', Image.asset('assets/images/music_icon.png', height: 30, width: 30,), Color(0x00FFFFFF), SoundsScreen.routName),
//  Destination('Favourite', Icons.favorite,  Color(0x00FFFFFF), SelectedSoundsScreen.routName),
  Destination('Settings', Image.asset('assets/images/settings_icon.png', height: 30, width: 30,), Color(0x00FFFFFF), SettingsScreen.routName)
];