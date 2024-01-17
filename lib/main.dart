import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/NETWORK/base_client.dart';
import '/UTILS/app_color.dart';
import '/WIDGETS/web_drag_scroll_behavior.dart';
import 'CONTROLERS/home_conntroller.dart';
import 'CONTROLERS/user_conntroller.dart';
import 'LOGIN/login_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void loadMap() {
  Future.delayed(
    Duration.zero,
    () {
      // Create a JavaScript script tag with the API key
      var script = ScriptElement()
        ..type = 'text/javascript'
        ..innerHtml = '''
    var yourfish = '${BaseClient.a + BaseClient.b + BaseClient.c + BaseClient.d}';
 
    // Load the Google Maps JavaScript API
    var script = document.createElement('script');
    script.src = 'https://maps.googleapis.com/maps/api/js?key=' + yourfish + '&libraries=drawing,places';
    script.async = true;
    script.defer = true;
    script.onload = function() {
     
    };
    document.head.appendChild(script);
    ''';
      // Append the script tag to the document's head
      document.head?.append(script);
    },
  );
}

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(UserController());
  Get.put(HomeController());

  loadMap();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Become Secure',
      debugShowCheckedModeBanner: false,
      scrollBehavior: WebDragScrollBehavior(),
      color: primaryColor,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          scaffoldBackgroundColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Poppins"),
      home: LoginPage(),
    );
  }
}
