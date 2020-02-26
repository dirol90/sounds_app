import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_app/model/sound.dart';
import 'package:sounds_app/screen/screen_main_holder.dart';
import 'package:sounds_app/screen/screen_player.dart';

class SoundsScreen extends StatefulWidget {
  static const String routName = '/SoundsScreen';
  static int startIndex = 0;
  static List<Sound> soundsList = List();

  @override
  _SoundsScreenState createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var controller = ScrollController(initialScrollOffset: 50.0);

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {
//      if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          controller.animateTo(0.toDouble(),
              curve: Curves.ease, duration: Duration(milliseconds: 500));
          print("scroll lost to ${_tabController.index}");
          break;
        case 1:
          controller.animateTo(200 * 6 + 32.toDouble(),
              curve: Curves.ease, duration: Duration(milliseconds: 500));
          print("scroll lost to ${_tabController.index}");
          break;
        case 2:
          controller.animateTo(200 * 10 + 32.toDouble(),
              curve: Curves.ease, duration: Duration(milliseconds: 500));
          print("scroll lost to ${_tabController.index}");
          break;
      }
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var lastEddedThemeIndex = -1;


    if (SoundsScreen.startIndex != -1) {
      _tabController.index = SoundsScreen.startIndex;
      _tabController.notifyListeners();
      SoundsScreen.startIndex = -1;
    }

    if (SoundsScreen.soundsList.isEmpty) {
      SoundsScreen.soundsList.add(
          Sound('assets/images/1.png', 'Fireplace', true, 1.toString(), 0, "1mt6d-y5_8CkIVyRVxS83J8lKFy8JnRER"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/2.png', 'Rain', true, 2.toString(), 0, "1up1sMVM27vCs82B70lxNSLEhDzjm4U98"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/3.png', 'Cicadas', false, 3.toString(), 0, "1lkfab_7rh5-vqJ4xra922BPLMVJYLqLF"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/4.png', 'Water', false, 4.toString(), 0, "1ZjGvExpEa6IY8xcvp8Vd-GyFBoR3Vb--"));
      SoundsScreen.soundsList.add(
          Sound('assets/images/5.png', 'Small Stream', false, 5.toString(), 0, "1x3VKtCN67VbKkg3YvI4vlnbMnkyR09Zf"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/6.png', 'Thender', false, 6.toString(), 0, "1V0twoKmZl9-5iB5kQGu0gEa2CXJyasrs"));
      SoundsScreen.soundsList.add(
          Sound('assets/images/7.png', 'Wind Forest', false, 7.toString(), 0, "1gCCEbTazlHmy7GeAEMTcpkoGXITiedwD"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/8.png', 'Bird', false, 8.toString(), 0, "1NxNJu2S89GyzxOY-Aa3XmYmxayOUR6qg"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/9.png', 'Waves', false, 9.toString(), 0, "12PBlFmFpS8D_pbAa5OgMZz6mynDz4Yog"));
      SoundsScreen.soundsList.add(
          Sound('assets/images/10.png', 'Waterfalls', false, 10.toString(), 0, "1S2bhauQB0iif1Olawg_kRRmQVqIH6I6N"));
      SoundsScreen.soundsList.add(Sound('assets/images/11.png',
          'Wind in the trees', false, 11.toString(), 0, "1mmHvmpLoDi80nDpZip2wQ8C2fJcZAuIZ"));
      SoundsScreen.soundsList.add(
          Sound('assets/images/12.png', 'Jungle', false, 12.toString(), 0, "1AE67TQsKpSDYjFLsHT-lrV0g8HiN2wHv"));
      SoundsScreen.soundsList.add(
          Sound('assets/images/13.png', 'Spring', false, 13.toString(), 0, "1yGq0dY0TWnuUcp5jSPq263OLWq4hNKWc"));
      SoundsScreen.soundsList.add(Sound(
          'assets/images/14.png', 'Warm afternoon', false, 14.toString(), 0, "1GIMxfYDZWNrbPnOraje9FBuxz4WbBnRc"));
      SoundsScreen.soundsList
          .add(Sound('assets/images/15.png', 'Farm', false, 15.toString(), 0, "13Z4DSfgNwEgn8o-RQQDfACBjNAEGxSL8"));
    }

    _tabController.addListener(_handleTabSelection);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: Platform.isIOS
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height,
                child: ListView.builder(
                    controller: controller,
                    itemCount: SoundsScreen.soundsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (lastEddedThemeIndex <
                          SoundsScreen.soundsList[index].themeIndex) {
                        lastEddedThemeIndex =
                            SoundsScreen.soundsList[index].themeIndex;
                        return Container(
                          child: Column(
                            children: <Widget>[
//                              Divider(
//                                height: 5,
//                              ),
////                              Text(
////                                'Theme ${SoundsScreen.soundsList[index].themeIndex}',
////                                style: Theme.of(context).textTheme.title,
////                              ),
//                              Divider(
//                                height: 5,
//                              ),
                              GestureDetector(
                                onTap: () {
                                  PlayerScreen.playingSound =
                                      SoundsScreen.soundsList[index];
                                  PlayerScreen.disableCurrentTrack = true;
                                  var provider =
                                      Provider.of<MainScreenHolder>(context);
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
                                            colors: [
                                              Colors.indigo,
                                              Colors.transparent
                                            ],
                                          ).createShader(Rect.fromLTRB(0, 0,
                                              rect.width * 2, rect.height * 2));
                                        },
                                        blendMode: BlendMode.dstIn,
                                        child: Image.asset(
                                            SoundsScreen
                                                .soundsList[index].imagePath,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                SoundsScreen
                                                    .soundsList[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead,
                                              ),
                                            ),
                                            SoundsScreen
                                                    .soundsList[index].isPremium
                                                ? Container(
                                                    child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Premium',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subhead,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Image.asset(
                                                          'assets/images/crown.png',
                                                          height: 15,
                                                          width: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ))
                                                : Container(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            PlayerScreen.playingSound =
                                SoundsScreen.soundsList[index];
                            PlayerScreen.disableCurrentTrack = true;
                            var provider =
                                Provider.of<MainScreenHolder>(context);
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
                                      colors: [
                                        Colors.indigo,
                                        Colors.transparent
                                      ],
                                    ).createShader(Rect.fromLTRB(
                                        0, 0, rect.width * 2, rect.height * 2));
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: Image.asset(
                                      SoundsScreen.soundsList[index].imagePath,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          SoundsScreen.soundsList[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                      ),
                                      SoundsScreen.soundsList[index].isPremium
                                          ? Container(
                                              child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Premium',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subhead,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Image.asset(
                                                    'assets/images/crown.png',
                                                    height: 15,
                                                    width: 12,
                                                  ),
                                                )
                                              ],
                                            ))
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 76,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.55, 0.85, 0.95, 1],
                      colors: [Color(0xFF000000), Color(0x80000000), Color(0x40000000), Color(0x03000000)])),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: Center(
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white.withOpacity(0.1),
                      indicatorColor: Colors.white,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'MEDITATE',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'SLEEP',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'ASMR',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
