import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'product/pricelist.product.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});

  @override
  State<StatefulWidget> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {
  @override
  void initState() {
    super.initState();
    // Inicializa os dados quando o widget é criado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final gridColumns = screenSize.width < 600 ? 2 : 6;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('AUCTION RIO VERDE - GO'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.error != null) {
            return Center(child: Text('Erro: ${productProvider.error}'));
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('Sem dados produtos'));
          }

          final productList = productProvider.products;
          final authorization = productProvider.authorization;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('SUPER PROMOÇÕES', textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.getProductsOnSale().length,
                    itemBuilder: (context, index) {
                      final saleProducts = productProvider.getProductsOnSale();
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 180,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => product_priceList(
                                      id: saleProducts[index].id.toString(),
                                      authorization: authorization,
                                      img_url: saleProducts[index].img_url,
                                    ),
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
                                    'http://localhost:8000/uploads/${saleProducts[index].img_url}',
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "${saleProducts[index].name} \nMarca: ${saleProducts[index].mark} \nTamanho: ${saleProducts[index].unidade_measure} \nCategoria: ${saleProducts[index].category}",
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

                const Divider(
                  color: Colors.brown,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Center(child: Text('MAIS PRODUTOS')),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridColumns,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount:
                        productList.length > 16 ? 16 : productList.length,
                    itemBuilder: (context, index) {
                      final fontSize =
                          MediaQuery.of(context).size.width < 800 ? 12.0 : 14.0;
                      final listProducts = productProvider.getProductsOffSale();
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => product_priceList(
                                    id: listProducts[index].id.toString(),
                                    authorization: authorization,
                                    img_url: listProducts[index].img_url,
                                  ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.network(
                                  'http://localhost:8000/uploads/${listProducts[index].img_url}',
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Nome: ${listProducts[index].name} \nMarca: ${listProducts[index].mark} \nTamanho: ${listProducts[index].unidade_measure}",
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
        },
      ),
    );
  }
}
