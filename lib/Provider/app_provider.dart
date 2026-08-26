
import 'package:flutter/material.dart';


class AppProvider with ChangeNotifier{
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}