import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/pricelist.dart';
import 'package:front_leilaorv/service/services.pricelist.dart';

class PriceListProvider with ChangeNotifier {
  Map<int, List<PriceList>> _productPrices = {};
  Map<int, bool> _loadingStates = {};
  String? _error;

  final PriceListService _priceListService = PriceListService();

  Map<int, List<PriceList>> get productPrices => _productPrices;
  bool isLoadingFor(int productId) => _loadingStates[productId] ?? false;
  String? get error => _error;

  Future<List<PriceList>> getProductPrices(int productId, String authorization) async {
    // Verificar se já temos os preços em cache
    if (_productPrices.containsKey(productId)) {
      return _productPrices[productId]!;
    }

    // Verificar se já estamos carregando este produto
    if (_loadingStates[productId] == true) {
      // Aguardar até que o carregamento seja concluído
      while (_loadingStates[productId] == true) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
      if (_productPrices.containsKey(productId)) {
        return _productPrices[productId]!;
      }
    }

    // Marcar como carregando sem notificar
    _loadingStates[productId] = true;

    try {
      final prices = await _priceListService.getAllPriceListId(productId, authorization);
      _productPrices[productId] = prices;
      return prices;
    } catch (e) {
      _error = e.toString();
      return [];
    } finally {
      // Remover estado de carregamento
      _loadingStates[productId] = false;
    }
  }

  // Método para obter o menor preço de um produto
  double? getLowestPrice(int productId) {
    if (!_productPrices.containsKey(productId) || _productPrices[productId]!.isEmpty) {
      return null;
    }

    return _productPrices[productId]!
        .map((price) => double.tryParse(price.price) ?? double.infinity)
        .reduce((value, element) => value < element ? value : element);
  }

  // Limpar cache de preços
  void clearCache() {
    _productPrices.clear();
    _loadingStates.clear();
    notifyListeners();
  }
}
