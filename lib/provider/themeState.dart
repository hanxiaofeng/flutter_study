
import 'package:flutter/cupertino.dart';

class ThemeState with ChangeNotifier{

  String _stateMode;

  ThemeState(this._stateMode);

  get stateMode => _stateMode;

  void updateThemeState(String theme){
    _stateMode = theme;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    print("---------------test");
    super.notifyListeners();
  }
}


