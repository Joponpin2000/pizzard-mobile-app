import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListTile(
          leading: Text('Change Theme'),
          trailing: IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.lightbulb_outline
                : Icons.highlight),
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
              );
            },
          ),
        ),
      ),
    );
  }
}

//     IconButton(
//       icon: Icon(Theme.of(context).brightness == Brightness.light
//           ? Icons.lightbulb_outline
//           : Icons.highlight),
//       onPressed: () {
//         DynamicTheme.of(context).setBrightness(
//           Theme.of(context).brightness == Brightness.light
//               ? Brightness.dark
//               : Brightness.light,
//         );
//       },
//     ),
