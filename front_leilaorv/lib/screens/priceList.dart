import 'package:flutter/material.dart';

class product_priceList extends StatefulWidget {
  const product_priceList({super.key});

  @override
  State<StatefulWidget> createState() => _product_priceList();
}

class _product_priceList extends State<product_priceList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Preço dos  Produtos"),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
