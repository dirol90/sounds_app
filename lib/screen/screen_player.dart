import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounds_app/helper/CustomCacheManager.dart';
import 'package:sounds_app/model/sound.dart';
import 'package:sounds_app/screen/screen_selected_soundes.dart';
import 'package:sounds_app/screen/screen_sounds.dart';
import 'package:sounds_app/widget/bg_image.dart';

class PlayerScreen extends StatefulWidget {
  static const String routName = '/PlayerScreen';
  static bool isRunAudioInBackground = true;
  static Sound playingSound = Sound('assets/images/1.png', 'Fireplace', true,
      1.toString(), 0, "1mt6d-y5_8CkIVyRVxS83J8lKFy8JnRER");
  static bool disableCurrentTrack = false;

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

int fileInt = 1;

class _PlayerScreenState extends State<PlayerScreen>
    with WidgetsBindingObserver {
  var likeBtn = false;
  var playBtn = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        print('inactive!!!');
        if (!PlayerScreen.isRunAudioInBackground) stopLocal();
        break;
      case AppLifecycleState.resumed:
        print('resumed!!!');
        break;
      case AppLifecycleState.paused:
        print('paused!!!');
        if (!PlayerScreen.isRunAudioInBackground) stopLocal();
        break;
      default:
//      case AppLifecycleState.suspending:
//        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = ScrollController();
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Duration timer = const Duration();

  var voiceLoud = 1.0;
  var isBottomDialogShown = false;
  var showProgressIndicator = false;


  ScrollController _controller;
  var lastScrollPos = 0.0;

  void _handleTabSelection() {
    setState(() {
      if (lastScrollPos < _controller.position.pixels) {
        print(PlayerScreen.playingSound.imagePath);
        PlayerScreen.playingSound = SoundsScreen.soundsList[
            _controller.position.pixels ~/ MediaQuery.of(context).size.width];
        _controller.animateTo(
            (((_controller.position.pixels ~/
                        MediaQuery.of(context).size.width) +
                    1) *
                MediaQuery.of(context).size.width),
            duration: Duration(milliseconds: 150),
            curve: Curves.ease);
        lastScrollPos = _controller.position.pixels;
      } else {
        print(PlayerScreen.playingSound.imagePath);
        PlayerScreen.playingSound = SoundsScreen.soundsList[
            _controller.position.pixels ~/ MediaQuery.of(context).size.width];
        _controller.animateTo(
            (((_controller.position.pixels ~/
                    MediaQuery.of(context).size.width)) *
                MediaQuery.of(context).size.width),
            duration: Duration(milliseconds: 150),
            curve: Curves.ease);
        lastScrollPos = _controller.position.pixels;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (PlayerScreen.disableCurrentTrack) {
          print(
              'Scroll to : ${(int.parse(PlayerScreen.playingSound.audioFileIntPuth) - 1)}');
          if (_controller.hasClients) {
            _controller.jumpTo(
                (double.parse(PlayerScreen.playingSound.audioFileIntPuth) - 1) *
                    MediaQuery.of(context).size.width);
            lastScrollPos = _controller.position.pixels;
          }
          playBtn = false;
          stopLocal();
          PlayerScreen.disableCurrentTrack = false;
        }
      });
    });


    return Stack(
      children: <Widget>[
        ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: SoundsScreen.soundsList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return BGImage(
                path: SoundsScreen.soundsList[index].imagePath,
              );
            }),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 42, 16, 0),
                  child: Container(
                    height: 32,
                    width: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 256),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      timer.inMilliseconds > 0
                          ? Text(
                              '${timer.inHours > 0 ? "${timer.inHours}:" : ''}${timer.inMinutes % 60 < 10 ? 0 : ''}${timer.inMinutes % 60}:${timer.inSeconds % 60 < 10 ? 0 : ''}${timer.inSeconds % 60}',
                              style: Theme.of(context).textTheme.title,
                              textScaleFactor: 0.9,
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: Platform.isIOS
                      ? EdgeInsets.fromLTRB(0, 0, 0, 52)
                      : EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            playBtn = !playBtn;
                            if (playBtn) {
                              setState(() {
                                showProgressIndicator = true;
                              });
                              playLocal(
                                  PlayerScreen.playingSound.audioFileIntPuth);
                            } else {
                              stopLocal();
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            !playBtn ? Icons.play_arrow : Icons.pause,
                            size: 48,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 200,
                                    height: 20,
                                    child: Card(
                                      color: Colors.transparent,
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    child: Transform.scale(
                                      scale: 1.15,
                                      child: CupertinoSlider(
                                        min: 0.0,
                                        max: 1.0,
                                        value: voiceLoud,
                                        activeColor: Colors.transparent,
                                        onChanged: (double value) {
                                          setState(() {
                                            voiceLoud = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBottomDialogShown = !isBottomDialogShown;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.alarm,
                            size: 42,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: Platform.isIOS
                ? EdgeInsets.fromLTRB(0, 0, 0, 0)
                : EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: isBottomDialogShown
                ? Container(
//              color: Theme.of(context).primaryColor,
                    height: 346,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      color: Color(0xff16123D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(28.0),
                            topLeft: Radius.circular(28.0),
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0)),
                      ),
//                elevation: 8,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 175,
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hms,
                                minuteInterval: 1,
                                secondInterval: 1,
                                onTimerDurationChanged: (Duration newTimer) {
                                  setState(() => timer = newTimer);
                                },
                                initialTimerDuration: timer,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(47, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      timer = const Duration();
                                      isBottomDialogShown =
                                          !isBottomDialogShown;
                                    });
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff757575)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 58, 0),
                                  child: Container(
                                      width: 64.0,
                                      height: 64.0,
                                      child: new RawMaterialButton(
                                        fillColor: Colors.green,
                                        shape: new CircleBorder(),
                                        elevation: 0.0,
                                        child: Text(
                                          'Start',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xffFFFFFF)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isBottomDialogShown =
                                                !isBottomDialogShown;
                                            playLocal(PlayerScreen
                                                .playingSound.audioFileIntPuth);
                                            if (!playBtn) playBtn = true;
                                          });
                                        },
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
        showProgressIndicator
            ? Align(
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : Container(),
      ],
    );
  }

  Duration duration;
  Duration position;

  AudioPlayerState palyerState;
  AudioPlayer audioPlayer;

  DateTime oldDateTime;
  Timer t;

  static final platformAndroid =
      const MethodChannel('net.sounds.app.sounds_app/setNotification');
  static final platformIOs =
      const MethodChannel('net.sounds.app.sounds_app/ios_player');
  static final platformAndroid2 =
      const MethodChannel('net.sounds.app.sounds_app/responceNotification');

  Future<void> _didRecieveIOsTranscript(MethodCall call) async {
    print('IOS callback');
    switch (call.method) {
      case "play":
        await audioPlayer.play(
            'https://drive.google.com/uc?authuser=0&id=${PlayerScreen.playingSound.trackHashKey}&export=download');
        break;
      case "stop":
        await audioPlayer.stop();
        break;
    }
  }

  Future<void> _didRecieveTranscriptAndroidRespponce(MethodCall call) async {
    print('Android Responce callback');
    switch (call.method) {
      case "play":
        await audioPlayer.play(
            'https://drive.google.com/uc?authuser=0&id=${PlayerScreen.playingSound.trackHashKey}&export=download');
        break;
      case "stop":
        playBtn = false;
        stopLocal();
        break;
    }
  }

  Future<void> _didRecieveTranscriptAndroid() async {
    await platformAndroid.invokeMethod('setNotification');
  }

  playLocal(String s) async {
    showProgressIndicator = true;
    PlayerScreen.disableCurrentTrack = false;

    try {
      await stopLocal();
    } catch (e) {
      e.toString();
    }

    if (Platform.isIOS) {
      platformIOs.setMethodCallHandler(this._didRecieveIOsTranscript);
    } else {
      await _didRecieveTranscriptAndroid();
      platformAndroid2
          .setMethodCallHandler(this._didRecieveTranscriptAndroidRespponce);
    }

    if (timer.inSeconds > 0) {
      t = Timer.periodic(Duration(seconds: 1), (timerL) {
        if (timer.inSeconds > 0) {
          setState(() {
            timer = Duration(seconds: timer.inSeconds - 1);
          });
        } else {
          setState(() {
            timer = const Duration();
            stopLocal();
            playBtn = false;
            oldDateTime = null;
            t?.cancel();
          });
        }
      });
    }

    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioPlayer.setVolume(voiceLoud);

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
        audioPlayer.setVolume(voiceLoud);
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        audioPlayer.setVolume(voiceLoud);
      });
    });

    audioPlayer.onPlayerError.listen((msg) {
      setState(() {
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });

    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    FileInfo fileInfo;
    CustomCacheManager().getFile(
            'https://drive.google.com/uc?authuser=0&id=${PlayerScreen.playingSound.trackHashKey}&export=download')
        .listen((f) {
      setState(() {
        fileInfo = f;
        try{audioPlayer.play(fileInfo.file.path);} catch (e){
          Fluttertoast.showToast(
              msg: "There are some problems while audio downloading, please try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0
          );
        }
        showProgressIndicator = false;
      });
    }).onError((e) {
      setState(() {
        fileInfo = null;
        print(e.toString());
        Fluttertoast.showToast(
            msg: "There are some problems while audio downloading, please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0
        );
      });
    });
  }

//    var initializationSettingsAndroid =
//        new AndroidInitializationSettings('crown');
//    var initializationSettingsIOS = new IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, 'Sounds app',
//        'Tap notification to stop sounds', platformChannelSpecifics,
//        payload: 'item x');
//}

//  Future onSelectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
//
//    await stopLocal();
//    playBtn = false;
//    await Navigator.pushReplacement(
//      context,
//      new MaterialPageRoute(builder: (context) => MainScreenHolder()),
//    );
//  }
//
//  Future onDidReceiveLocalNotification(
//      int id, String title, String body, String payload) async {
//    // display a dialog with the notification details, tap ok to go to another page
//    showDialog(
//      context: context,
//      builder: (BuildContext context) => new CupertinoAlertDialog(
//        title: new Text(title),
//        content: new Text(body),
//        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: new Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await stopLocal();
//              await Navigator.pushReplacement(
//                context,
//                new MaterialPageRoute(builder: (context) => MainScreenHolder()),
//              );
//            },
//          )
//        ],
//      ),
//    );
//  }

  stopLocal() async {
    showProgressIndicator = false;
    await flutterLocalNotificationsPlugin.cancelAll();
    t?.cancel();
    if (audioPlayer != null) audioPlayer.stop();
    AudioCache().clearCache();
  }
}
