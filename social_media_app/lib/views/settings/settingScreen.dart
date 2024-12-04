import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/themeprovider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<Themeprovider>(context);
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Text(
            'Change Theme',
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Switch(
            value: themeprovider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeprovider.toggleTheme(value);
            },
          )
        ],
      ),
    );
  }
}
