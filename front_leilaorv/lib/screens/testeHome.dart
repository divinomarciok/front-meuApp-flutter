import 'package:flutter/material.dart';
import '../models/enterprise.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});

  @override
  State<StatefulWidget> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final screenSize = MediaQuery.of(context).size;
    final gridColumns = screenSize.width < 600 ? 2 : 6;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AUCTION RIO VERDE - GO '),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('SUPER PROMOÇÕES', textAlign: TextAlign.left),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 180,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.network(
                              'https://i1.wp.com/qrofertas.s3.us-west-2.amazonaws.com/imagens-ads/d0691886-4ea4-4e5b-bc76-ca1a9e680b38-modelo-de-encarte-4-tema-4159-pagina-1-art-82761.jpg?w=582',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Nome: Produto \nPreço: 10.00 \nMarca:Generico Simples \nMercado:Conquista",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(color: Colors.brown, thickness: 1, indent: 5, endIndent: 5),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(child: Text('MAIS PRODUTOS')),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true, // Adicione esta linha
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns, // Adaptativo
                  childAspectRatio: 0.7, // Melhor proporção para celular
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final fontSize =
                      MediaQuery.of(context).size.width < 800 ? 12.0 : 14.0;

                  /* return Card(
                    elevation: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calcula tamanhos baseados no espaço disponível
                        final cardWidth = constraints.maxWidth;
                        final imageHeight =
                            cardWidth * 0.60; // 80% do card para imagem
                        final textHeight =
                            cardWidth * 0.40; // 20% do card para texto
                        final fontSize =
                            cardWidth < 100 ? 9.0 : 12.0; // Ajuste de fonte

                        return Column(
                          children: [
                            SizedBox(
                              height: imageHeight,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.network(
                                  'https://cdn.iset.io/assets/60955/produtos/452/abacate.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: textHeight,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Nome: Produto \nPreço: 10.00 \nMarca:Generico Simples \nMercado:Conquista",
                                  style: TextStyle(fontSize: fontSize),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );*/

                  return Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        // Imagem
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.network(
                            height: 130,
                            'https://cdn.iset.io/assets/60955/produtos/452/abacate.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Texto
                        Expanded(
                          //padding: const EdgeInsets.all(0.0),
                          child: Center(
                            child: Text(
                              "Nome: Produto \nPreço: 10.00 \nMarca:Generico Simples \nMercado:Conquista",
                              style: TextStyle(fontSize: fontSize),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        // Imagem
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.network(
                            'https://cdn.iset.io/assets/60955/produtos/452/abacate.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
