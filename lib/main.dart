import 'package:eventmanagementapp/adminwidget/feeedbackform.dart';

import '../pages/admindashboard.dart';
import '../pages/login.dart';
import '../pages/userdashboard.dart';
import '../widgets/signupwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.displayName == 'user') {
              return const UserDashboard();
            }
            if (snapshot.data?.displayName == 'admin') {
              return const AdminDashboard();
            }
            return const LoginPage();
          }
          return const LoginPage();
        },
      ),
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        SignUpWidget.routeName: (_) => const SignUpWidget(),
        UserDashboard.routeName: (_) => const UserDashboard(),
        FeedbackForm.routeName: (_) => const FeedbackForm(),
      },
    );
  }
}
