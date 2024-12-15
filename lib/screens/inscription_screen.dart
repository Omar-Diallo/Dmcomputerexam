import 'package:daroulmoukhtycomputer/screens/inscription_screen.dart';
import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _seConnecter() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs !')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('https://dmcomputer.sn/wp-json/jwt-auth/v1/token'), // Remplacez par l'URL de votre API
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Authentification réussie
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion réussie !')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuScreen()));
    } else {
      // Authentification échouée
      String errorMessage;
      try {
        final errorResponse = json.decode(response.body);
        errorMessage = errorResponse['message'] ?? 'Échec de la connexion.';
      } catch (e) {
        errorMessage = 'Erreur inconnue : ${response.body}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la connexion : $errorMessage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Connexion',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.white, Colors.green, Colors.white],
                begin: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Bienvenue",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Connectez-vous pour continuer", style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 20),

                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email, color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),

                        SizedBox(height: 10),

                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: "Mot de passe",
                            prefixIcon: Icon(Icons.lock, color: Colors.green),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.green),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),

                        SizedBox(height: 20),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _seConnecter, // Appel de la méthode d'authentification
                          child: Text(
                            "Se Connecter",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pas encore de compte ? ", style: TextStyle(color: Colors.grey)),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}