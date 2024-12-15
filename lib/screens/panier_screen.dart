import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menu_screen.dart';

class Article {
  final String nom;
  final double prix;

  Article({required this.nom, required this.prix});
}

class Product {
  final String imageUrl;
  final String name;
  final double price;

  Product({required this.imageUrl, required this.name, required this.price});
}

class PanierScreen extends StatefulWidget {
  const PanierScreen({super.key});

  @override
  State<PanierScreen> createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  final List<Article> _panier = [];
  List<Product> _produits = [];
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts({int categoryId = 0}) async {
    String url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    if (categoryId > 0) {
      url += '?category=$categoryId';
    }

    setState(() {
      _loading = true; // Démarrer le chargement
      _errorMessage = null; // Réinitialiser le message d'erreur
    });

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> productsData = json.decode(response.body);
        setState(() {
          _produits = productsData.map((product) {
            return Product(
              imageUrl: product['images'].isNotEmpty ? product['images'][0]['src'] : '',
              name: product['name'],
              price: double.parse(product['price']),
            );
          }).toList();
          _loading = false; // Terminer le chargement
        });
      } else {
        throw Exception('Échec du chargement des produits');
      }
    } catch (e) {
      print("Erreur lors de la récupération des produits: $e");
      showErrorDialog(context, "Échec du chargement des produits. Veuillez réessayer plus tard.");
      setState(() {
        _loading = false; // Terminer le chargement même en cas d'erreur
        _errorMessage = "Erreur lors de la récupération des produits.";
      });
    }
  }

  // Méthode pour afficher un dialogue d'erreur
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _ajouterArticle(Article article) {
    setState(() {
      _panier.add(article);
    });
  }

  void _supprimerArticle(int index) {
    setState(() {
      _panier.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen()));
          },
          icon: Icon(Icons.arrow_back, size: 30),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Panier',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red)))
          : _panier.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, size: 150, color: Colors.grey),
              SizedBox(height: 10),
              Text('Votre panier est vide', style: TextStyle(fontSize: 20, color: Colors.grey)),
            ],
          ),
        ),
      )
          : ListView.builder(
        itemCount: _panier.length,
        itemBuilder: (context, index) {
          final article = _panier[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(article.nom),
              subtitle: Text('\$${article.prix.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => _supprimerArticle(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showProduitsDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _showProduitsDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choisissez un produit'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _produits.length,
              itemBuilder: (context, index) {
                final produit = _produits[index];
                return ListTile(
                  leading: produit.imageUrl.isNotEmpty
                      ? Image.network(produit.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                      : null,
                  title: Text(produit.name),
                  subtitle: Text('\$${produit.price.toStringAsFixed(2)}'),
                  onTap: () {
                    _ajouterArticle(Article(nom: produit.name, prix: produit.price));
                    Navigator.of(context).pop(); // Fermer le dialogue
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}