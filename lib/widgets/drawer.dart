import 'dart:async';

import 'package:flutter/material.dart';

class MyDrawerWidget extends StatelessWidget {
  final bool darkThemeEnabled;
  MyDrawerWidget({this.darkThemeEnabled});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Dark Theme"),
            trailing: Switch(
              value: darkThemeEnabled,
              onChanged: bloc.changeTheme,
            ),
          ),
        ],
      ),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
