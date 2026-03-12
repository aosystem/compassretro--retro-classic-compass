import 'package:flutter/cupertino.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass with ChangeNotifier {

  double _angle = 0;

  double get angle => _angle;

  Compass() {
    FlutterCompass.events!.listen((value) {
      _angle = -1 * 3.141592 * (value.heading! / 180);
      notifyListeners();
    });
  }
}
