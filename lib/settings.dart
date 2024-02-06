// settings_page.dart

import 'package:flutter/material.dart';
// settings_page.dart

class SettingsPage extends StatefulWidget {
  final Function(String) onBusIdChanged;

  SettingsPage({required this.onBusIdChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _busIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _busIdController,
              decoration: InputDecoration(labelText: 'Enter Bus ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Access the entered busId from _busIdController.text
                String newBusId = _busIdController.text;
                // Use the callback to update the busId in SharedData
                widget.onBusIdChanged(newBusId);
                // Optionally, you can also update other parts of the app
                // or perform any additional actions related to the busId change.
                print("New Bus ID: $newBusId");
                // Return the newBusId as a result to the previous screen
                Navigator.pop(context, newBusId);
              },
              child: Text("Save Bus ID"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _busIdController.dispose();
    super.dispose();
  }
}
