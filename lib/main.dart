import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reto/pages/home_page.dart';
import 'package:reto/pages/login.dart';
import 'package:reto/providers/auth_provider.dart';
import 'package:reto/providers/data_sync_provider.dart';
import 'package:reto/providers/to_do_list_provider.dart';
import 'package:reto/services/data_sync_service.dart';

CheckInternetConnection internetChecker = CheckInternetConnection();

void main() async {
  await Hive.initFlutter();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ConnectionStatusProvider()),
      ChangeNotifierProvider(create: (_) => ToDoListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> appRoutes = {
      // 'loading': (_) => const LoadingPage(),
      'home': (_) => const HomePage(
            name: 'lau',
          ),
      'login': (_) => const LoginPage(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: appRoutes,
      initialRoute: 'home',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.deepPurpleAccent),
      ),
    );
  }
}
