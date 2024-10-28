import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto/pages/home_page.dart';
import 'package:reto/pages/login.dart';
import 'package:reto/providers/toDoListProvider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoListProvider()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(BuildContext)> appRoutes = {
      // 'loading': (_) => const LoadingPage(),
      'home': (_) => const HomePage(),
      'login': (_) => const LoginPage(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: appRoutes,
      initialRoute: 'home',
    );
  }
}
