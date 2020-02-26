import 'package:flutter/material.dart';

class RoundedBtn extends StatefulWidget {
  final Function function;
  final double padding;
  final double borderRadius;
  final double height;
  final double width;
  final Color color;
  final String btnText;

  RoundedBtn({this.function, this.padding, this.borderRadius, this.color, this.width, this.height, this.btnText});

  @override
  _RoundedBtnState createState() => _RoundedBtnState();
}

class _RoundedBtnState extends State<RoundedBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                side: BorderSide(color: Theme.of(context).accentColor)),
            onPressed: () {widget.function();},
            child: FittedBox(fit:BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    widget.btnText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
            ),

          ),
        ),
      ),
    );
  }
}
