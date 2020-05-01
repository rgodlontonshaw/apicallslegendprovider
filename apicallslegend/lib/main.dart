import 'package:apicallslegend/providers/ChuckyJokeProvider.dart';
import 'package:apicallslegend/providers/ChuckyProvider.dart';
import 'package:apicallslegend/view/init/InitializeProviderDataScreen.dart';
import 'package:apicallslegend/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    run();
  });
}

void run() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ChuckyProvider()),
          ChangeNotifierProvider(create: (context) => ChuckyJokeProvider()),
        ],
        child: MaterialApp(
            title: 'Api Calls like a Legend with Provider',
            home: SplashScreen()));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  Future checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    String loggedIn = await storage.read(key: "loginstatus");
    if (loggedIn == null || loggedIn == "loggedout") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      if (loggedIn == "loggedin") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    InitializeProviderDataScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          'assets/images/flutter.png',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
