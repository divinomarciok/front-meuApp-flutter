import 'package:flutter/material.dart';
import 'package:front_leilaorv/data/providers/auth.provider.dart';
import 'package:front_leilaorv/screens/screen.login.dart';
import 'package:front_leilaorv/screens/user/screen.register.user.dart';
import 'package:front_leilaorv/service/service.token.storage.dart';
import 'package:provider/provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'package:front_leilaorv/screens/screen.home_old.dart';
import 'package:front_leilaorv/data/providers/pricelist.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();

  // Recupera o token salvo e seta no provider
  final token = await TokenStorageService().getToken();
  if (token != null && token.isNotEmpty) {
    authProvider.setToken(token);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => PriceListProvider()),
      ],
      child: const leilaoApp(),
    ),
  );
}

class leilaoApp extends StatelessWidget {
  const leilaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Leilão Rio Verde",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => leilaoHome(),
      },
      //home: const leilaoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
