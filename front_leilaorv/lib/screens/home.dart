import 'package:flutter/material.dart';
import 'package:front_leilaorv/service/fetchEnterprises.dart';
import '../models/enterprise.dart';

class leilaoHome extends StatefulWidget {
  const leilaoHome({super.key});
  @override
  State<leilaoHome> createState() => _leilaoHomeState();
}

class _leilaoHomeState extends State<leilaoHome> {

  late Future<dynamic> _enterprisesFuture;
  final EnterpriseService _service = EnterpriseService();

  @override
  void initState() {
    super.initState();
    _enterprisesFuture = _service.getAllEnterprise();
  }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Leilão Rio Verde"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          height: 400,
          child: ListView.builder(
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
          ),
        ),
      );
    }
  }

