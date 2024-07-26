import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};  // Change the type to CartItem

  Map<String, CartItem> get items => _items;

  void addItem(String name, double price) {
    if (_items.containsKey(name)) {
      _items[name]!.quantity++;
    } else {
      _items[name] = CartItem(name: name, price: price);
    }
    notifyListeners();
  }

  void updateItem(String name, int quantity) {
    if (_items.containsKey(name) && quantity > 0) {
      _items[name]!.quantity = quantity;
    } else if (quantity == 0) {
      _items.remove(name);
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _items.remove(name);
    notifyListeners();
  }
}


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              cart.items.clear();
              cart.notifyListeners();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                String itemName = cart.items.keys.elementAt(index);
                CartItem item = cart.items[itemName]!;
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        int newQuantity = item.quantity;
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.black),
                                        onPressed: () {
                                          cart.removeItem(item.name);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('100', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text('grammes', style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove_circle, color: Colors.red),
                                            onPressed: () {
                                              if (newQuantity > 1) {
                                                setState(() {
                                                  newQuantity--;
                                                });
                                              }
                                            },
                                          ),
                                          Text(newQuantity.toString(), style: TextStyle(fontSize: 18)),
                                          IconButton(
                                            icon: Icon(Icons.add_circle, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                newQuantity++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      cart.updateItem(item.name, newQuantity);
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text('Mettre à jour', style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item.quantity} x 100 g'),
                    trailing: Text('€ ${(item.quantity * item.price).toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('TOTAL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '€ ${(cart.items.isNotEmpty ? cart.items.values.map((e) => e.quantity * e.price).reduce((a, b) => a + b) : 0).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle payment action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('PAYER', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



