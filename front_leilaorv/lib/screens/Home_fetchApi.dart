import 'package:flutter/material.dart';
import 'package:front_leilaorv/service/fetchProduct.dart';
import '../screens/priceList.dart';
import '../models/products.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});

  @override
  State<StatefulWidget> createState() => _leilaoHomeState();
}

late Future<List<Product>> productFuture;

class _leilaoHomeState extends State<leilaoHome> {
  late Future<List<Product>> _productFuture;
  final ProductService _productService = ProductService();
  late String authorization =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibG9naW4iOiJhY2Vyb2xhIiwiaWF0IjoxNzQzODA3MjE1LCJleHAiOjE3NDM4MTA4MTV9.wkfeRx1v36mV7IDUDK3dMrQ_vTIFJg753zYDMSrlznw";

  @override
  void initState() {
    _productFuture = _productService.getAllProduct(authorization);
    super.initState();
  }

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
      body: FutureBuilder(
        future: _productFuture,
        builder: (context, snapshot) {
          {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Erro : ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return Text('Sem dados produtos');
            }

            final productList = snapshot.data;

            return SingleChildScrollView(
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
                      itemCount: productList?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 180,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => product_priceList(id:productList?[index].id),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image.network(
                                      //'https://i1.wp.com/qrofertas.s3.us-west-2.amazonaws.com/imagens-ads/d0691886-4ea4-4e5b-bc76-ca1a9e680b38-modelo-de-encarte-4-tema-4159-pagina-1-art-82761.jpg?w=582',
                                      'http://localhost:8000/${productList?[index].img_url}',
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "${productList?[index].nome} \nMarca: ${productList?[index].marca} \nTamanho: ${productList?[index].tamanho} \nCategoria: ${productList?[index].categoria}",
                                        //  "Nome: Produto \nPreço: 10.00 \nMarca:Generico Simples \nMercado:Conquista",
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.brown,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
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
                            MediaQuery.of(context).size.width < 800
                                ? 12.0
                                : 14.0;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => product_priceList(),
                              ),
                            );
                          },
                          child: Card(
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
