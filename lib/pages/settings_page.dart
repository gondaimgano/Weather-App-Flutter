import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showExtendedForecast = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Language'),
            trailing: Text(
              'English',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.ac_unit),
            title: const Text('Forecast up to 5 or 10 records'),
            value: _showExtendedForecast,
            onChanged: (value) {
              setState(() {
                _showExtendedForecast = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
