import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_leilaorv/data/providers/product.provider.dart';
import 'package:front_leilaorv/data/providers/pricelist.provider.dart';
import 'package:front_leilaorv/models/pricelist.dart';
import 'product/screen.pricelist.product.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});

  @override
  State<StatefulWidget> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  List<dynamic> _filteredProducts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Inicializa os dados quando o widget é criado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).initialize();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query, List<dynamic> products) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredProducts = [];
      });
      return;
    }

    final filtered =
        products.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase());
          //  product.category.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      _isSearching = true;
      _filteredProducts = filtered;
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
        actions: [
          // Menu de opções
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'add_product':
                  // Navegar para adicionar produto
                  break;
                case 'add_company':
                  // Navegar para adicionar empresa
                  break;
                case 'logout':
                  // Implementar logout
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'add_product',
                    child: Row(
                      children: [
                        Icon(Icons.add_box),
                        SizedBox(width: 8),
                        Text('Adicionar Produto'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'add_company',
                    child: Row(
                      children: [
                        Icon(Icons.business),
                        SizedBox(width: 8),
                        Text('Adicionar Empresa'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
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
                // Barra de pesquisa
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar por nome ou categoria...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterProducts('', productList);
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (value) => _filterProducts(value, productList),
                  ),
                ),

                // Mostrar resultados da pesquisa ou conteúdo normal
                if (_isSearching)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resultados da pesquisa (${_filteredProducts.length})',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridColumns,
                            childAspectRatio:
                                0.6, // Ajustado para dar mais espaço para o preço
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final fontSize =
                                MediaQuery.of(context).size.width < 800
                                    ? 12.0
                                    : 14.0;
                            return Consumer<PriceListProvider>(
                              builder: (context, priceProvider, _) {
                                return FutureBuilder<List<PriceList>>(
                                  future: priceProvider.getProductPrices(
                                    _filteredProducts[index].id,
                                    authorization,
                                  ),
                                  builder: (context, snapshot) {
                                    String priceText = "";

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        double lowestPrice = snapshot.data!
                                            .map(
                                              (price) =>
                                                  double.tryParse(
                                                    price.price,
                                                  ) ??
                                                  double.infinity,
                                            )
                                            .reduce(
                                              (value, element) =>
                                                  value < element
                                                      ? value
                                                      : element,
                                            );

                                        priceText =
                                            "R\$ ${lowestPrice.toStringAsFixed(2)}";
                                      }
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => product_priceList(
                                                  id:
                                                      _filteredProducts[index]
                                                          .id
                                                          .toString(),
                                                  authorization: authorization,
                                                  img_url:
                                                      _filteredProducts[index]
                                                          .img_url,
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
                                                'http://localhost:8000/uploads/${_filteredProducts[index].img_url}',
                                                height: 130,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: LayoutBuilder(
                                                builder: (
                                                  context,
                                                  constraints,
                                                ) {
                                                  final double availableHeight =
                                                      constraints.maxHeight;
                                                  final double textSize =
                                                      availableHeight < 60
                                                          ? 10.0
                                                          : fontSize;

                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${_filteredProducts[index].name} ${_filteredProducts[index].mark}",
                                                          style: TextStyle(
                                                            fontSize: textSize,
                                                          ),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        if (priceText
                                                            .isNotEmpty)
                                                          Text(
                                                            priceText,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green,
                                                              fontSize:
                                                                  textSize,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('PROMOÇÕES', textAlign: TextAlign.left),
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productProvider.getProductsOnSale().length,
                          itemBuilder: (context, index) {
                            final saleProducts =
                                productProvider.getProductsOnSale();

                            return Consumer<PriceListProvider>(
                              builder: (context, priceProvider, _) {
                                return FutureBuilder<List<PriceList>>(
                                  future: priceProvider.getProductPrices(
                                    saleProducts[index].id,
                                    authorization,
                                  ),
                                  builder: (context, snapshot) {
                                    String priceText = "";
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        double lowestPrice = snapshot.data!
                                            .map(
                                              (price) =>
                                                  double.tryParse(
                                                    price.price,
                                                  ) ??
                                                  double.infinity,
                                            )
                                            .reduce(
                                              (value, element) =>
                                                  value < element
                                                      ? value
                                                      : element,
                                            );
                                        priceText =
                                            "R\$ ${lowestPrice.toStringAsFixed(2)}";
                                      }
                                    }

                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 180,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      product_priceList(
                                                        id:
                                                            saleProducts[index]
                                                                .id
                                                                .toString(),
                                                        authorization:
                                                            authorization,
                                                        img_url:
                                                            saleProducts[index]
                                                                .img_url,
                                                      ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  5,
                                                ),
                                                child: Image.network(
                                                  'http://localhost:8000/uploads/${saleProducts[index].img_url}',
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${saleProducts[index].name} ${saleProducts[index].mark} \n ${saleProducts[index].weigth} ${saleProducts[index].unidade_measure}",
                                                        maxLines: 5,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      if (priceText.isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 4,
                                                              ),
                                                          child: Text(
                                                            priceText,
                                                            style:
                                                                const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .green,
                                                                  fontSize: 15,
                                                                ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridColumns,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 10,
                              ),
                          itemCount:
                              productList.length > 16 ? 16 : productList.length,
                          itemBuilder: (context, index) {
                            final fontSize =
                                MediaQuery.of(context).size.width < 800
                                    ? 12.0
                                    : 14.0;
                            final listProducts =
                                productProvider.getProductsOffSale();
                            return Consumer<PriceListProvider>(
                              builder: (context, priceProvider, _) {
                                return FutureBuilder<List<PriceList>>(
                                  future: priceProvider.getProductPrices(
                                    listProducts[index].id,
                                    authorization,
                                  ),
                                  builder: (context, snapshot) {
                                    String priceText = "";

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        double lowestPrice = snapshot.data!
                                            .map(
                                              (price) =>
                                                  double.tryParse(
                                                    price.price,
                                                  ) ??
                                                  double.infinity,
                                            )
                                            .reduce(
                                              (value, element) =>
                                                  value < element
                                                      ? value
                                                      : element,
                                            );

                                        priceText =
                                            "R\$ ${lowestPrice.toStringAsFixed(2)}";
                                      }
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => product_priceList(
                                                  id:
                                                      listProducts[index].id
                                                          .toString(),
                                                  authorization: authorization,
                                                  img_url:
                                                      listProducts[index]
                                                          .img_url,
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
                                              child: LayoutBuilder(
                                                builder: (
                                                  context,
                                                  constraints,
                                                ) {
                                                  // Ajusta o tamanho da fonte com base no espaço disponível
                                                  final double availableHeight =
                                                      constraints.maxHeight;
                                                  final double textSize =
                                                      availableHeight < 60
                                                          ? 10.0
                                                          : fontSize;
                                                  final double priceSize =
                                                      availableHeight < 60
                                                          ? 10.0
                                                          : 12.0;

                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${listProducts[index].name} ${listProducts[index].mark} \n ${listProducts[index].weigth} ${listProducts[index].unidade_measure}",
                                                          style: TextStyle(
                                                            fontSize: textSize,
                                                          ),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        if (priceText
                                                            .isNotEmpty)
                                                          Text(
                                                            priceText,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  textSize,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            /* Expanded(
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${listProducts[index].name} ${listProducts[index].mark} \n ${listProducts[index].weigth} ${listProducts[index].unidade_measure}",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    if (priceText.isNotEmpty)
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          priceText,
                                                          style:
                                                              const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors
                                                                        .green,
                                                              ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
