import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppearanceSettingsPage extends StatelessWidget {
  const AppearanceSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Appearance")),
        body: ListView(children: [
          ListTile(
              onTap: () => showAboutDialog(context: context),
              title: const Text("Language"),
              leading: const Icon(PhosphorIcons.translateLight))
        ]));
  }
}