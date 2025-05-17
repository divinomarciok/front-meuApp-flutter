import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'package:front_leilaorv/screens/home_old.dart';
import 'package:front_leilaorv/data/providers/pricelist.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
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
      home: const leilaoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
