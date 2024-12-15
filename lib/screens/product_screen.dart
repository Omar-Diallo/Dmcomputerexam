import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final int categoryId;

  ProductScreen({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Produits de la catégorie $categoryId'),
      ),
      body: Center(
        child: Text(
          'Liste des produits pour la catégorie ID : $categoryId',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
