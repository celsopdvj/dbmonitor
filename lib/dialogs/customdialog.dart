import 'package:flutter/material.dart';

class CustomDialog {
  static Future<Widget> show({String message, bool error = true, context}) {
    return showDialog(
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[800]),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Text(message,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center),
            ),
            Positioned(
              top: -80,
              child: Image.asset(
                error ? "assets/images/error.png" : "assets/images/check.png",
                width: 120,
                height: 120,
              ),
            )
          ],
        ),
      ),
      context: context,
    );
  }
}
