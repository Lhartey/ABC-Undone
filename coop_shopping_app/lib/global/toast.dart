import 'package:coop_shopping_app/pallete.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message,) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Pallete.gradient3,
    textColor: Pallete.gradient1,
    fontSize: 16.0,
  );
}
