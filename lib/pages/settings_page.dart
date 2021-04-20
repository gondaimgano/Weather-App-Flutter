import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SettingsList(
      sections: [
        SettingsSection(
          title: "Reference",
          tiles: [
            SettingsTile(title: "Language",trailing: Text("English"),),
            SettingsTile.switchTile(
              leading: Icon(Icons.ac_unit),
              title: "forecast upto 5 or 10 records",
              switchValue: true,
              onToggle: (bool){},
            )
          ],
        )
      ],
    ),);
  }
}
