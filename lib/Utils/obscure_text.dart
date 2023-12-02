
import 'package:flutter/foundation.dart';

class ObscureProvider with ChangeNotifier{
  bool isVisible = true;

  changeVisibility(){
    isVisible = !isVisible;
    notifyListeners();
  }
}