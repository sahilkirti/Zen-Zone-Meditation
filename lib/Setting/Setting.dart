import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _enableNotifications = true;
  int _selectedTheme = 0;
  List<String> _themeOptions = ['Light', 'Dark', 'System Default'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.abyssinicaSil(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Enable Notification',
              style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            value: _enableNotifications,
            onChanged: (value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
          ListTile(
            title: Text(
              'Theme',
              style: GoogleFonts.abyssinicaSil(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: Text(_themeOptions[_selectedTheme]),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Choose a theme'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: _themeOptions
                            .asMap()
                            .entries
                            .map(
                              (entry) => RadioListTile(
                                title: Text(entry.value),
                                value: entry.key,
                                groupValue: _selectedTheme,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTheme = value!;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
