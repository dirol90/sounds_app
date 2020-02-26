import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sounds_app/screen/screen_player.dart';
import 'package:sounds_app/screen/screen_start.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  static const String routName = '/SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS
          ? EdgeInsets.fromLTRB(0, 0, 0, 92)
          : EdgeInsets.fromLTRB(0, 0, 0, 62),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 36, 0, 42),
                  child: Text(
                    'SETTINGS'.toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                getSettingsRow('Run in background', null, () {
                  setState(() {
                    PlayerScreen.isRunAudioInBackground =
                        !PlayerScreen.isRunAudioInBackground;
                  });
                }),
                getSettingsRow('Get Premium', Icons.insert_emoticon, () {
                  Navigator.of(context)
                      .pushReplacementNamed(SplashScreen.routName);
                }),
                Platform.isIOS
                    ? getSettingsRow(
                        'Restore Purchases', Icons.shopping_cart, () {})
                    : Container(),
                getSettingsRow('Rate App', Icons.star, () {
                  if (Platform.isAndroid) {
                    _launchURL(
                        'https://play.google.com/store/apps/details?id=com.miniclip.eightballpool&hl=ru');
                  } else if (Platform.isIOS) {
                    _launchURL('https://www.apple.com/ipad-mini/');
                  }
                }),
                getSettingsRow('Tell Friends', Icons.share, () {
                  if (Platform.isAndroid) {
                    Share.share(
                        'Check out our website https://play.google.com/store/apps?hl=ru');
                  } else if (Platform.isIOS) {
                    Share.share(
                        'Check out our website https://www.apple.com/ios/app-store/');
                  }
                }),
              ],
            ),
          ),
          Text(
            'Privacy policy',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2,
          )
        ],
      ),
    );
  }

  Widget getSettingsRow(String s, IconData i, Function f) {
    return GestureDetector(
      onTap: () {
        f();
      },
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    s,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Container(width: 64,child: Center(child: i != null
                      ? Icon(
                    i,
                    size: 32,
                    color: Theme.of(context).primaryColor,
                  )
                      : Transform.scale(
                      scale: 0.7,
                      child: Container(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white, width: 0.0),
                              borderRadius: new BorderRadius.all(
                                  Radius.elliptical(360, 360))),
                          child: CupertinoSwitch(
                            activeColor: Color(0xff1C174D),
                            value: PlayerScreen.isRunAudioInBackground,
                            onChanged: (bool value) {
                              setState(() {
                                PlayerScreen.isRunAudioInBackground = value;
                              });
                            },
                          ),
                        ),
                      )),))
                ],
              ),
            ],
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Divider(
              height: 1,
              color: Colors.grey,
            ))
      ]),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
