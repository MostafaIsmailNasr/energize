import 'package:energize_flutter/ui/screens/Add_payload/add_payload_screen.dart';
import 'package:energize_flutter/ui/screens/Add_payload/choose_client/choose_client_screen.dart';
import 'package:energize_flutter/ui/screens/Add_payload/choose_delegate/choose_delegate_sscreen.dart';
import 'package:energize_flutter/ui/screens/Add_payload/choose_driver/choose_driver_screen.dart';
import 'package:energize_flutter/ui/screens/auth/login/login_screen.dart';
import 'package:energize_flutter/ui/screens/auth/splash/splash_screen.dart';
import 'package:energize_flutter/ui/screens/dialogs/add_branch/add_branch_dialog.dart';
import 'package:energize_flutter/ui/screens/home/home_screen.dart';
import 'package:energize_flutter/ui/screens/menu/branches/branches_details/branches_details_screen.dart';
import 'package:energize_flutter/ui/screens/menu/branches/branches_screen.dart';
import 'package:energize_flutter/ui/screens/menu/carOwner/car_owner_screen.dart';
import 'package:energize_flutter/ui/screens/menu/cities/addCity/add_city_screen.dart';
import 'package:energize_flutter/ui/screens/menu/cities/cities_screen.dart';
import 'package:energize_flutter/ui/screens/menu/clients/add_client/add_client_screen.dart';
import 'package:energize_flutter/ui/screens/menu/clients/clients_screen.dart';
import 'package:energize_flutter/ui/screens/menu/comprehensive_reports/comprehensive_reports_screen.dart';
import 'package:energize_flutter/ui/screens/menu/customer_reports/Customer_reports_screen.dart';
import 'package:energize_flutter/ui/screens/menu/delegate/add_delegate/add_delegate_screen.dart';
import 'package:energize_flutter/ui/screens/menu/delegate/delegate_screen.dart';
import 'package:energize_flutter/ui/screens/menu/drivers/add_driver/add_driver_screen.dart';
import 'package:energize_flutter/ui/screens/menu/drivers/drivers_screen.dart';
import 'package:energize_flutter/ui/screens/menu/profile/profile_screen.dart';
import 'package:energize_flutter/ui/screens/notes/notes_screen.dart';
import 'package:energize_flutter/ui/screens/notification/notification_screen.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer.dart';
import 'package:energize_flutter/ui/screens/shimer_pages/shimmer_category.dart';
import 'package:energize_flutter/ui/screens/shipment_categories_details/shipment_category_details_screen.dart';
import 'package:energize_flutter/ui/screens/shipment_details/shipment_details_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_client/update_client_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_delegate/update_delegate_screen.dart';
import 'package:energize_flutter/ui/screens/update/update_driver/update_driver_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppRouter{
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case'/':
        return MaterialPageRoute(builder: (_)=> SplashScreen());
      case'/login_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/home_screen':
        return PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
                HomeScreen(),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.centerLeft,
              );
            },
          );
      case '/notification_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              NotificationScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/shipment_category_details_screen':
        final appbarTitle=settings.arguments as String;
        final state=settings.arguments as String;
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ShipmentCategoryDetailsScreen(appbarTitle: appbarTitle,state: state),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
          //MaterialPageRoute(builder: (_)=> ShipmentCategoryDetailsScreen(appbarTitle: appbarTitle,));
      case '/add_payload_screen':
        final from=settings.arguments as String;
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddPayloadScreen(fromWhere: from),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/choose_client_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds:1 ),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ChooseClientScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/choose_driver_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ChooseDriverScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/cities_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              CitiesScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/choose_delegate_sscreen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ChooseDelegateScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/branches_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              BranchesScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/car_owner_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              CarOwnerScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/branches_details_screen':
        final branchId=settings.arguments as int;
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              BranchesBetailsScreen(branchId: branchId),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
      case '/add_branch_dialog':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddBranchDialog(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/add_city_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddCityScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/clients_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ClientScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/add_client_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddClientScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/drivers_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              DriverScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/add_driver_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddDriverScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/profile_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ProfileScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/shipment_details_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              ShipmentDetailsScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
      case '/add_delegate_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              AddDelegateScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/delegate_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              DelegateScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/update_delegate_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              UpdateDelegateScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
      case '/update_client_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              UpdateClientScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
      case '/update_driver_screen':
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              UpdateDreiverScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
      case '/notes_screen':
        final orderId=settings.arguments as int;
        return PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
              NotesScreen(orderId: orderId),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            animation= CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
        );
      case '/comprehensive_reports_screen':
        WidgetsFlutterBinding.ensureInitialized();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
        return MaterialPageRoute(builder: (_)=> ComprehensiveReportsScreen());
      case '/customer_reports_screen':
        WidgetsFlutterBinding.ensureInitialized();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
        return MaterialPageRoute(builder: (_)=> CustomerReportsScreen());
      case '/shimmer':
        return MaterialPageRoute(builder: (_)=> shimmer());
      case '/shimmer_category':
        return MaterialPageRoute(builder: (_)=> ShimmerCategory());
    }
  }
}