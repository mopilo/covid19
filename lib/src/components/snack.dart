import 'package:flushbar/flushbar.dart';

void showMessage(msg, context) {
    Flushbar(
      message: msg.toUpperCase(),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }