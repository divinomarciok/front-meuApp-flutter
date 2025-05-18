import 'package:flutter/material.dart';
import 'package:front_leilaorv/models/products.dart';
import 'package:front_leilaorv/service/services.product.dart';
import 'package:front_leilaorv/service/services.login.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  final ProductService _productService = ProductService();
  final LoginService _loginService = LoginService();

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
     
 


Future<void> initialize(String token) async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    _products = await _productService.getAllProduct(token);
  } catch (e) {
    _error = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
 
  List<Product> getProductsOnSale() {
    return _products.where((product) => product.isSale).toList();
  }

  List<Product> getProductsOffSale() {
    return _products.where((product) => product.isSale == false).toList();
  }

 
}
