import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounds_app/model/sound.dart';
import 'package:sounds_app/screen/screen_main_holder.dart';
import 'package:sounds_app/screen/screen_player.dart';

class SelectedSoundsScreen extends StatefulWidget {
  static const String routName = '/SelectedSoundsScreen';
  static final List<Sound> soundList = List();


  @override
  _SelectedSoundsScreenState createState() => _SelectedSoundsScreenState();
}

class _SelectedSoundsScreenState extends State<SelectedSoundsScreen> {

  final List<Sound> _fullSoundsList = List();

  _loadLikedSound(List<Sound> _fullSoundsList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _fullSoundsList.length; i++){
      bool counter = prefs.getBool(_fullSoundsList[i].audioFileIntPuth) ?? false;
      if (counter){
        SelectedSoundsScreen.soundList.add(_fullSoundsList[i]);
      }
    }
  }

  _saveLikedSound(Sound s, bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(s.audioFileIntPuth, b);

    setState(() {
      SelectedSoundsScreen.soundList.remove(s);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // status bar color
    ));

    if (SelectedSoundsScreen.soundList.isEmpty){
//      _fullSoundsList.add(Sound('assets/images/1.png', 'Fireplace', true, 1.toString(), 0));
//      _fullSoundsList.add(Sound('assets/images/2.png', 'Rain', true, 2.toString(), 0));
//      _fullSoundsList.add(Sound('assets/images/3.png', 'Cicadas', false, 3.toString(), 0));
//      _fullSoundsList.add(Sound('assets/images/4.png', 'Water', false, 4.toString(), 0));
//      _fullSoundsList.add(Sound('assets/images/5.png', 'Small Stream', false, 5.toString(), 1));
//      _fullSoundsList.add(Sound('assets/images/6.png', 'Thender', false, 6.toString(), 1));
//      _fullSoundsList.add(Sound('assets/images/7.png', 'Wind Forest', false, 7.toString(), 1));
//      _fullSoundsList.add(Sound('assets/images/8.png', 'Bird', false, 8.toString(), 1));
//      _fullSoundsList.add(Sound('assets/images/9.png', 'Waves', false, 9.toString(), 1));
//      _fullSoundsList.add(Sound('assets/images/10.png', 'Waterfalls', false, 10.toString(), 2));
//      _fullSoundsList.add(Sound('assets/images/11.png', 'Wind in the trees', false, 11.toString(), 2));
//      _fullSoundsList.add(Sound('assets/images/12.png', 'Jungle', false, 12.toString(), 2));
//      _fullSoundsList.add(Sound('assets/images/13.png', 'Spring', false, 13.toString(), 2));
//      _fullSoundsList.add(Sound('assets/images/14.png', 'Warm afternoon', false, 14.toString(), 2));
//      _fullSoundsList.add(Sound('assets/images/15.png', 'Farm', false, 15.toString(), 2));

      _loadLikedSound(_fullSoundsList);

    }


    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 36, 0, 8),
            child: Text(
              'Selected'.toUpperCase(),
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SelectedSoundsScreen.soundList.length > 0 ?  Container(
            width: MediaQuery.of(context).size.width,
            height: Platform.isIOS? MediaQuery.of(context).size.height-(72+92) : MediaQuery.of(context).size.height-(72+52),
            child: ListView.builder(
                itemCount: SelectedSoundsScreen.soundList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return GestureDetector(
                    onTap: (){
                      PlayerScreen.playingSound  = SelectedSoundsScreen.soundList[index];
                      PlayerScreen.disableCurrentTrack = true;
                      var provider = Provider.of<MainScreenHolder>(context);
                      provider.currentIndex = 0;
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.indigo, Colors.transparent],
                              ).createShader(Rect.fromLTRB(
                                  0, 0, rect.width * 2, rect.height * 2));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(SelectedSoundsScreen.soundList[index].imagePath,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                fit: BoxFit.cover),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    SelectedSoundsScreen.soundList[index].name,
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                      _saveLikedSound(SelectedSoundsScreen.soundList[index], false);
                                  },
                                  child: Container(
                                      child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 32,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ) : Container(height: MediaQuery.of(context).size.height-175, child: Center(child: Text('No sounds selected yet...', style: Theme.of(context).textTheme.subhead, textAlign: TextAlign.center,),),),
        ],
      ),
    );
  }
}
