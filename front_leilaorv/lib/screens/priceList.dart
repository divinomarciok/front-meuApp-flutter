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
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.cyan,
          alignment: Alignment.center,
          //height: 240,
          child: Card(
            elevation: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 4.0,
                  child: Image.network(
                    height: 400,
                    'https://cdn.iset.io/assets/60955/produtos/452/abacate.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      //width: double.infinity,
                      width: 650,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Adiciona Preço Produto'),
                      ),
                    ),
                  ),
                  //  child: ElevatedButton(
                  //    onPressed: () {},
                  //    child: Text("teste"),
                  //  ),
                ),

                Center(
                  child: SizedBox(
                    height: 690,
                    width: 600,
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return Card(
                          // child: Card(
                          child: Column(
                            children: [Text('teste \n teste \n teste')],
                          ),
                          // ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
