import 'package:flutter/material.dart';
import 'package:front_leilaorv/service/fetchEnterprises.dart';
import '../models/enterprise.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});
  @override
  State<leilaoHome> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Leilão Rio Verde"),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              //color: Colors.amber,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 200,
                    //  color: Colors.blue,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.network(
                              'https://i1.wp.com/qrofertas.s3.us-west-2.amazonaws.com/imagens-ads/d0691886-4ea4-4e5b-bc76-ca1a9e680b38-modelo-de-encarte-4-tema-4159-pagina-1-art-82761.jpg?w=582',
                              height: 240,
                              //width: 240,
                              fit: BoxFit.cover,
                              //color: Colors.blueGrey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Center(
                              child: Text(
                                "Teste \n Aaaaaaaaaa \b aaaaaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaa \n aaaaaaa",
                              ),
                            ),
                            /* child:
                            
                            Text(
                              "Teste \n Aaaaaaaaaaaaa \b aaaaaaaaaaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaaaaa \n aaaaaaa",
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Mais Produtos')),
            ),
            Divider(color: Colors.grey, thickness: 1, indent: 5, endIndent: 5),
            Container(
              // height: 600,
              color: Colors.amber,

              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Image.network(
                              'http://localhost:8000/images/1743025306264-macafuji.jpg',
                              //height: 240,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              
                            ),
                              
                          ),
                         
                          
                        ),


                        

                        /*Expanded(
                          child: Center(
                            child: Image.network(
                              'http://localhost:8000/images/1743025306264-macafuji.jpg',
                              //height: 240,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Expanded(
                            child: Center(
                              child: Text(
                                "Teste \n Aaaaa \b aaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaaaaa \n aaaaaaa",
                                style: TextStyle(fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          /*child: Center(
                            child: Text(
                              "Teste \n Aaaaa \b aaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaaaaa \n aaaaaaa",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),*/
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Mais Produtos')),
            ),*/
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.network(
                              'https://cdn.iset.io/assets/60955/produtos/452/abacate.png',
                              //height: 240,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Center(
                              child: Text(
                                "Teste \n Aaaaa \b aaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaaaaa \n aaaaaaa",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          /*child: Center(
                            child: Text(
                              "Teste \n Aaaaa \b aaaaa \n aaaaa \n aaaaaa\n aaaaaaaaaaaaa \n aaaaaaa",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),*/
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
        /*child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              width: 200,
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.network(
                        'https://i1.wp.com/qrofertas.s3.us-west-2.amazonaws.com/imagens-ads/d0691886-4ea4-4e5b-bc76-ca1a9e680b38-modelo-de-encarte-4-tema-4159-pagina-1-art-82761.jpg?w=582',
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Produto $index+1 \nR\$ 100,00 \nCategoria : Congelados \nMarca : Boa ",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),*/
      ),
    );
  }
}
