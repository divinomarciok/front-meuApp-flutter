import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/enterprise.dart';
import 'package:front_leilaorv/service/service.enterprises.dart';
import '../../service/services.pricelist.dart';

class AddPriceScreen extends StatefulWidget {
  final String productId;
  final String authorization;
  final String productName;
  final String? productImage;

  const AddPriceScreen({
    Key? key,
    required this.productId,
    required this.authorization,
    required this.productName,
    this.productImage,
  }) : super(key: key);

  @override
  State<AddPriceScreen> createState() => _AddPriceScreenState();
}

class _AddPriceScreenState extends State<AddPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  bool _isSale = false;
  bool _isLoading = false;
  List<Enterprise> _enterprises = [];
  Enterprise? _selectedEnterprise;

  final EnterpriseService _enterpriseService = EnterpriseService();
  final PriceListService _priceService = PriceListService();

  @override
  void initState() {
    super.initState();
    _loadEnterprises();
  }

  Future<void> _loadEnterprises() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final enterprises = await _enterpriseService.getAllEnterprise(
        widget.authorization,
      );

      setState(() {
        _enterprises = enterprises;
        if (_enterprises.isNotEmpty) {
          _selectedEnterprise = _enterprises.first;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar empresas: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedEnterprise != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _priceService.addPrice(
          widget.authorization,
          int.parse(widget.productId),
          _selectedEnterprise!.id,
          double.parse(_priceController.text),
          _isSale,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Preço adicionado com sucesso!')),
          );
          Navigator.pop(context, true); // Retorna true para indicar sucesso
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Preço'),
        backgroundColor: Colors.lightGreen,
      ),
      body:
          _isLoading && _enterprises.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Informações do produto
                              if (widget.productImage != null)
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.network(
                                    'http://localhost:8000/uploads/${widget.productImage}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(height: 16),
                              Text(
                                'Produto: ${widget.productName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Seleção de empresa
                              DropdownButtonFormField<Enterprise>(
                                decoration: const InputDecoration(
                                  labelText: 'Empresa',
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedEnterprise,
                                items:
                                    _enterprises.map((enterprise) {
                                      return DropdownMenuItem<Enterprise>(
                                        value: enterprise,
                                        child: Text(enterprise.name),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedEnterprise = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor, selecione uma empresa';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Campo de preço
                              TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Preço (R\$)',
                                  border: OutlineInputBorder(),
                                  prefixText: 'R\$ ',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o preço';
                                  }
                                  try {
                                    double.parse(value);
                                  } catch (e) {
                                    return 'Por favor, insira um valor válido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Opção de promoção
                              SwitchListTile(
                                title: const Text('Preço promocional'),
                                value: _isSale,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isSale = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child:
                            _isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  'SALVAR PREÇO',
                                  style: TextStyle(fontSize: 16),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
