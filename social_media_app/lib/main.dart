import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/controllers/authProvider.dart';
import 'package:social_media_app/controllers/expandedTextprovider.dart';
import 'package:social_media_app/controllers/navigationbarProvider.dart';
import 'package:social_media_app/controllers/postProvider.dart';
import 'package:social_media_app/controllers/themeprovider.dart';
import 'package:social_media_app/views/auth/LoginScreen.dart';

import 'package:social_media_app/views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokens = prefs.getString('token');
    return tokens == null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Authprovider()),
          ChangeNotifierProvider(create: (_) => Navigationbarprovider()),
          ChangeNotifierProvider(create: (_) => Themeprovider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => Expandedtextprovider()),
        ],
        child: Consumer<Themeprovider>(builder: (context, themeprovider, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Fingering',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark().copyWith(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
              themeMode: themeprovider.themeMode,
              home: FutureBuilder<bool>(
                  future: isUserLoggedIn(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return snapshot.data!
                          ? const DashboardScreen()
                          : LoginScreen();
                    }
                    return LoginScreen();
                  })

              // LoginScreen(),
              );
        }));
  }
}
