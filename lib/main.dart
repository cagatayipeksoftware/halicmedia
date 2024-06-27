import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halicmedia/providers/user_provider.dart';
import 'package:halicmedia/responsive/mobile_screen_layout.dart';
import 'package:halicmedia/responsive/responsive_layout_screen.dart';
import 'package:halicmedia/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halicmedia/screens/login_screen.dart';
import 'package:halicmedia/screens/onboarding_screen.dart';
import 'package:halicmedia/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [Locale("tr")],
          title: "Halic Social",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }

              return const LoginScreen();
            },
            stream: FirebaseAuth.instance.authStateChanges(),
          )),
    );
  }
}
