import 'package:flutter/material.dart';
import 'package:sounds_app/widget/bg_image.dart';
import 'package:sounds_app/widget/rounded_btn.dart';

import 'screen_main_holder.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSecondStep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BGImage(
            path: 'assets/images/bg.png',
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 75, 0, 75),
                  child: Image.asset(
                    'assets/images/subscription_img.png',
                    height: 210,
                    width: 231,
                  ),
                ),
                !isSecondStep
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Do you want to activate\n full version and unlock\n all sounds for best experience',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                            RoundedBtn(
                              width: 256,
                              height: 50,
                              btnText: 'YES, UNLOCK IT',
                              color: Theme.of(context).buttonColor,
                              padding: 12,
                              borderRadius: 10,
                              function: () {
                                Navigator.of(context).pushReplacementNamed(
                                    MainScreenHolder.routName);
                              },
                            ),
                            RoundedBtn(
                              width: 256,
                              height: 50,
                              btnText:
                                  '3 DAYS FREE TRIAL\n Then 2,99\$ per week',
                              color: Theme.of(context).buttonColor,
                              padding: 12,
                              borderRadius: 10,
                              function: () {
                                setState(() {
                                  isSecondStep = true;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            RoundedBtn(
                              width: 256,
                              height: 50,
                              btnText: 'YES, UNLOCK IT',
                              color: Theme.of(context).buttonColor,
                              padding: 12,
                              borderRadius: 10,
                              function: () {
                                Navigator.of(context).pushReplacementNamed(
                                    MainScreenHolder.routName);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                '( you have 3-Day FREE trial...\nafter 2,99\$ per week )',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 64, 0, 0),
              child: isSecondStep
                  ? Container(
                      height: 38,
                      width: 38,
                      child: Stack(
                        children: <Widget>[
                          Image.asset('assets/images/star_img.png'),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    MainScreenHolder.routName);
                              },
                              child: Align(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.center,
                              )),

                        ],
                      ))
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
