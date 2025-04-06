import 'package:flutter/material.dart';
import 'package:front_leilaorv/service/fetchLogin.dart';
import 'package:front_leilaorv/service/fetchProduct.dart';
import '../screens/priceList_api.dart';
import '../models/products.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});

  @override
  State<StatefulWidget> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {
  late String _authorization;
  late Future<List<Product>> _productFuture = Future.value([]);

  final LoginService _loginService = LoginService();
  final ProductService _productService = ProductService();

  // O   initState não funciona async diretamente, necessario criar uma função assincrona para chamar dentro dele
  Future<void> _initData() async {
    _authorization = await _loginService.returnLogin("acerola", "123456");
    print("Auth Home : $_authorization");
    _productFuture = _productService.getAllProduct(_authorization);

    setState(() {}); // Atualiza a interface, se necessário
  }

  @override
  void initState() {
    _initData();
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
                                  builder:
                                      (context) => product_priceList(
                                        id: productList![index].id,
                                        authorization: _authorization,
                                        img_url: productList[index].img_url,
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
                                builder:
                                    (context) => product_priceList(
                                      id: productList![index].id,
                                      authorization: _authorization,
                                      img_url: productList[index].img_url,
                                    ),
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
