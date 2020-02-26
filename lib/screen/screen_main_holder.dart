import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sounds_app/navigation/destination_view.dart';
import 'package:sounds_app/navigation/destinations.dart';
import 'package:sounds_app/screen/screen_sounds.dart';

class MainScreenHolder extends StatefulWidget with ChangeNotifier {
  static const String routName = '/StartScreen';

  @override
  _MainScreenHolderState createState() => _MainScreenHolderState();
  int _currentIndex = 0;

  get currentIndex {
    return _currentIndex;
  }

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class _MainScreenHolderState extends State<MainScreenHolder>
    with ChangeNotifier, TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller2;
  Animation<Offset> offset;
  Animation<Offset> offset2;
  bool isShowBottomDialog = false;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(controller);

    offset2 = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return ChangeNotifierProvider<MainScreenHolder>(
      builder: (context) => MainScreenHolder(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Consumer<MainScreenHolder>(
              builder: (context, model, child) => IndexedStack(
                index: Provider.of<MainScreenHolder>(context).currentIndex,
                children:
                    allDestinations.map<Widget>((Destination destination) {
                  return DestinationView(destination: destination);
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: offset,
                child: Container(
                  color: Color(0x00FFFFFF).withOpacity(0.0),
//                decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        begin: Alignment.topCenter,
//                        end: Alignment.bottomCenter,
//                        colors: [Colors.transparent, Colors.black])),
                  child: Container(
                    height: 225,
                    decoration: BoxDecoration(
                      color: Color(0xff16123D),
//                    border: Border.all(color: Color(0x00FFFFFF), width: 0.0),
                      borderRadius: new BorderRadius.vertical(
                          top: Radius.elliptical(240, 80)),
                    ),
                    child: Card(
                      color: Colors.transparent,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      elevation: 4,
                      child: Container(
                        height: 150,
                        child: Column(
                          children: <Widget>[
                            Consumer<MainScreenHolder>(
                              builder: (context, model, child) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      SoundsScreen.startIndex = 0;
                                      Provider.of<MainScreenHolder>(context)
                                          .currentIndex = 1;
                                      isShowBottomDialog = false;
                                      contrillersReverse();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 64, 16, 16),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/meditation_icon.png',
                                              height: 50 / 4 * 3,
                                              width: 50 / 4 * 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Meditate",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      SoundsScreen.startIndex = 1;
                                      Provider.of<MainScreenHolder>(context)
                                          .currentIndex = 1;
                                      isShowBottomDialog = false;
                                      contrillersReverse();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/sleep_icon.png',
                                              height: 50 / 4 * 3,
                                              width: 50 / 4 * 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Sleep",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      SoundsScreen.startIndex = 2;
                                      Provider.of<MainScreenHolder>(context)
                                          .currentIndex = 1;
                                      isShowBottomDialog = false;
                                      contrillersReverse();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 64, 40, 16),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/asmr_icon.png',
                                              height: 50 / 4 * 3,
                                              width: 28 / 4 * 3,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "ASMR",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isShowBottomDialog = false;
                                        contrillersReverse();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/music_icon.png',
                                        height: 56 / 4 * 3,
                                        width: 50 / 4 * 3,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<MainScreenHolder>(
                builder: (context, model, child) => SlideTransition(
                    position: offset2,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
//                            0.15,
                            0.50,
                            0.75,
                            1
                          ],
                              colors: [
//                            Color(0xFF000000),
                            Color(0x80000000),
                            Color(0x40000000),
                            Color(0x03000000)
                          ])),
                      child: BottomNavigationBar(
//                            fixedColor: Color(0x00FFFFFF),
                        currentIndex:
                            Provider.of<MainScreenHolder>(context).currentIndex,
                        onTap: (int index) {
                          setState(() {
                            if (index != 1) {
                              Provider.of<MainScreenHolder>(context)
                                  .currentIndex = index;
                            } else {
                              isShowBottomDialog = true;
                              contrillersReverse();
                            }
                          });
                        },
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        selectedFontSize: 12,
                        unselectedFontSize: 12,
                        iconSize: 20,
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Color(0x00FFFFFF).withOpacity(0.0),
                        selectedLabelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xffFFFFFF)),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xffFFFFFF)),
                        items: allDestinations.map((Destination destination) {
                          return BottomNavigationBarItem(
                              icon: destination.image,
                              backgroundColor: destination.color,
                              title: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 1.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xffFFFFFF)),
                              ));
                        }).toList(),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void contrillersReverse() {
    switch (controller.status) {
      case AnimationStatus.completed:
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      default:
    }
    switch (controller2.status) {
      case AnimationStatus.completed:
        controller2.reverse();
        break;
      case AnimationStatus.dismissed:
        controller2.forward();
        break;
      default:
    }
  }
}
