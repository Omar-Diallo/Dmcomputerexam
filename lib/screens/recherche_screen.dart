import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menu_screen.dart';

class RechercheSceeen extends StatefulWidget {
  const RechercheSceeen({super.key});

  @override
  State<RechercheSceeen> createState() => _RechercheSceeenState();
}

class _RechercheSceeenState extends State<RechercheSceeen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _results = [];
  bool _loading = false;

  void _searchProduct() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true; // Démarrer le chargement
      _results = []; // Réinitialiser les résultats
    });

    try {
      final response = await http.get(
        Uri.parse('https://dmcomputer.sn/wp-json/wc/v3/products?search=$query'),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _results = json.decode(response.body);
          _loading = false; // Terminer le chargement
        });
      } else {
        throw Exception('Échec de la recherche');
      }
    } catch (e) {
      print("Erreur lors de la recherche: $e");
      setState(() {
        _loading = false; // Terminer le chargement même en cas d'erreur
      });
      _showErrorDialog('Erreur lors de la recherche des produits.');
    }
  }

  void _showErrorDialog(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MenuScreen()));
          },
          icon: Icon(Icons.arrow_back, size: 30),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Rechercher un produit DMC',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Rechercher un produit...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchProduct(); // Lancer la recherche
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                ),
                SizedBox(height: 10),
                _loading
                    ? CircularProgressIndicator() // Afficher le chargement
                    : _results.isEmpty
                    ? Text(
                  'Aucun résultat trouvé',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final product = _results[index];
                    return ListTile(
                      title: Text(product['name']),
                      subtitle: Text('\$${product['price']}'),
                      leading: product['images'].isNotEmpty
                          ? Image.network(product['images'][0]['src'], width: 50, height: 50)
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}