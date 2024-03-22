// settings_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// settings_page.dart

class SettingsPage extends StatefulWidget {
  final Function(String) onBusIdChanged;

  const SettingsPage({super.key, required this.onBusIdChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _busIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _busIdController,
              decoration: const InputDecoration(labelText: 'Enter Bus ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Access the entered busId from _busIdController.text
                String newBusId = _busIdController.text;
                // Use the callback to update the busId in SharedData
                widget.onBusIdChanged(newBusId);
                // Optionally, you can also update other parts of the app
                // or perform any additional actions related to the busId change.
                saveData();
                print("New Bus ID: $newBusId");
                // Return the newBusId as a result to the previous screen
                Navigator.pop(context, newBusId);
              },
              child: const Text("Save Bus ID"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('busId', _busIdController.text);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _busIdController.dispose();
    super.dispose();
  }
}
