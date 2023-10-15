import 'package:flutter/foundation.dart';
import 'Product Provider.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getWishItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  Future<void> addWishItem(
      String name,
      double price,
      List imagesUrl,
      String documentId,
      String suppId
      ) async {
    final product = Product(
        name: name,
        price: price,
        imagesUrl: imagesUrl,
        documentId: documentId,
      suppId : suppId
        );
    _list.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishlist() {
    _list.clear();
    notifyListeners();
  }

  void removeThis(String id) {
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}
