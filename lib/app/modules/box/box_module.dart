import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hellomultlan/app/modules/box/pages/box_page.dart';

class BoxModule extends FlutterGetItModule {
  @override
  String get moduleRouteName => "/box";

  @override
  Map<String, WidgetBuilder> get pages => {
        "/": (_) => const BoxPage(),
      };
}
