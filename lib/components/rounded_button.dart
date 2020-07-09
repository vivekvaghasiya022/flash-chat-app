import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String name;
  final Color color;
  final Function onPress;
  const RoundedButton({this.name, this.color,@required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Color(0xFFFEA5A6),
        borderRadius: BorderRadius.circular(12.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 54.0,
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'SofiaPro'),
          ),
        ),
      ),
    );
  }
}
