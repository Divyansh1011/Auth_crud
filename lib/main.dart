import 'package:compound/ui/views/loading.dart';
import 'package:compound/ui/views/start_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Compound',
            builder: (context, child) => Navigator(
              key: locator<DialogService>().dialogNavigationKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => DialogManager(child: child)),
            ),
            navigatorKey: locator<NavigationService>().navigationKey,
            theme: ThemeData(
              primaryColor: Color.fromARGB(255, 9, 202, 172),
              backgroundColor: Color.fromARGB(255, 26, 27, 30),
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Open Sans',
                  ),
            ),
            home: StartUpView(),
            onGenerateRoute: generateRoute,
          );
        }

        return Loading();
      },
    );
  }
}
