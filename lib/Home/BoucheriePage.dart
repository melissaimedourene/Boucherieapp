import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Panier.dart';

import 'package:flutter/material.dart';


class BoucheriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boucherie'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset('assets/Merguez.jpg'), // Update with correct path
            title: Text('Merguez 2Kg'),
            subtitle: Text('€ 19,90'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    productName: 'Merguez 2Kg',
                    productPrice: 19.90,
                    productImage: 'assets/Merguez.jpg',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/poulet.jpg'), // Update with correct path
            title: Text('3 Poulets Pac'),
            subtitle: Text('€ 12,90'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    productName: '3 Poulets Pac',
                    productPrice: 12.90,
                    productImage: 'assets/poulet.jpg',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/viande-hachee.jpg'), // Update with correct path
            title: Text('Viande Hachée'),
            subtitle: Text('€ 21,90'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    productName: 'Viande Hachée',
                    productPrice: 21.90,
                    productImage: 'assets/viande-hachee.jpg',
                  ),
                ),
              );
            },
          ),
          // Add more ListTiles for other products...
        ],
      ),
    );
  }
}


class ProductDetailPage extends StatelessWidget {
  final String productName;
  final double productPrice; // Change to double
  final String productImage;

  ProductDetailPage({
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Column(
        children: [
          Image.asset(productImage),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '€ ${productPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addItem(productName, productPrice);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$productName ajouté au panier')),
                );
              },
              child: Text('Ajouter au panier'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Retrait des commandes:\n',
                  ),
                  TextSpan(
                    text: 'Du lundi au vendredi: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Passez votre commande au moins 1 heure à l\'avance (sauf indication contraire sur le produit).\n',
                  ),
                  TextSpan(
                    text: 'Le week-end: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Commandez au moins 1 heure et 30 minutes à l\'avance pour garantir la disponibilité.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
