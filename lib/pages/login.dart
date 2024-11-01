import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto/pages/home_page.dart';
import 'package:reto/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final userCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Abrí sesión para ver tus tareas'),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: userCtrl,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: passwordCtrl,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      prefixIcon: const Icon(Icons.lock_outlined),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: authProvider.authenticating
                      ? () {}
                      : () async {
                          FocusScope.of(context).unfocus();
                          final loginOk = await authProvider.signIn(
                              userCtrl.text.trim(), passwordCtrl.text.trim());

                          if (loginOk == true) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(
                                  name: userCtrl.text.trim(),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Credenciales incorrectas'),
                            ));
                          }
                        },
                  elevation: 2,
                  highlightElevation: 5,
                  shape: const StadiumBorder(),
                  color: Colors.deepPurpleAccent,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
