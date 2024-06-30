import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppRouter.dart';
import 'business/loginController/LoginBinding.dart';
import 'conustant/AppLocale.dart';
import 'notification_service.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

NotificationService notificationService = NotificationService();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await NotificationService().init();
  await notificationService.initializePlatformNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.red, // Set the color of the status bar
  //     statusBarBrightness: Brightness.dark, // Set the brightness of the status bar text and icons
  //     statusBarIconBrightness: Brightness.dark, // Set the brightness of the status bar icons
  //   ),
  // );


  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.appRouter});
  final AppRouter appRouter;

  saveLang(String lang)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang',lang);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale("en",""),
        Locale("ar",""),
      ],
      localeResolutionCallback: (currentLang,supportedLang){
        if(currentLang!=null){
          for(Locale locale in supportedLang){
            if(locale.languageCode==currentLang.languageCode){
              saveLang(currentLang.toString());
              return currentLang;
            }
          }
        }else{
          return supportedLang.first;
        }
      },
      initialBinding: LoginBinding(),
    );
  }
}

