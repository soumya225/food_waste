import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_waste/screens/add_selected_products_screen.dart';
import 'package:food_waste/screens/home_screen.dart';
import 'package:food_waste/screens/input_search_screen.dart';
import 'package:food_waste/screens/login_screen.dart';
import 'package:food_waste/screens/register_screen.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/services/connectivity_service.dart';
import 'package:food_waste/services/notification_service.dart';
import 'package:food_waste/utilities.dart';
import 'package:food_waste/widgets/network_detection_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => ConnectivityService())
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();

    return Provider<ConnectivityStatus>(
      create: (context) => ConnectivityService().connectionStatus,
      child: MaterialApp(
        title: 'Butler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFFf9aa33))
            )
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Color(0xFFf9aa33),
            indicator: BoxDecoration(
              border: Border.all(
                color: Color(0xFFf9aa33),
                width: 2.0
              )
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(
                Color(0xFF344955).value,
                {
                  50: Color(0xFFe8f0f6),
                  100: Color(0xFFcbd9e1),
                  200: Color(0xFFadc0cb),
                  300: Color(0xFF8da6b5),
                  400: Color(0xFF7592a3),
                  500: Color(0xFF5d7f92),
                  600: Color(0xFF517081),
                  700: Color(0xFF425c6a),
                  800: Color(0xFF344955),
                  900: Color(0xFF23343e),
                }
              ),
            accentColor: Color(0xFFf9aa33)
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w300,
              fontSize: 22,
            ),
            subtitle1: TextStyle(
              fontFamily: "Raleway",
              fontSize: 16,
            ),
            subtitle2: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            bodyText1: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              fontFamily: "Raleway",
              fontSize: 14,
            ),
            button: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null ? "/login" : "/home",
        routes: {
          "/login": (BuildContext ctx) => LoginScreen(),
          "/register": (BuildContext ctx) => RegisterScreen(),
          "/home": (BuildContext ctx) => HomeScreen(),
          "/input_search": (BuildContext ctx) => InputSearchScreen(),
          "/add_selected_products": (BuildContext ctx) => AddSelectedProductsScreen(),
        }
      ),
    );
  }
}

