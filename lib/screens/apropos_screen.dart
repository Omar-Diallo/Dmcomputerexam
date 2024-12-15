import 'package:flutter/material.dart';

class AproposScreen extends StatelessWidget {
  const AproposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // To go back to the previous screen
          },
          icon: Icon(Icons.arrow_back, size: 30),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'À propos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo (optional)
              Center(
                child: Icon(
                  Icons.info_outline,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              // Title and description of the app
              Text(
                'Nom de l\'application:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Votre application Flutter',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Cette application vous permet de vous connecter et d\'accéder à différentes fonctionnalités utiles.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              Text(
                'Version:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              Text(
                'Développeur:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Nom du Développeur',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 5),
              Text(
                'Email: dev@example.com',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              Text(
                'Crédit:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Cette application utilise des ressources de Flutter, une plateforme open-source.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Add More Texts for a richer "About" page
              Text(
                'Fonctionnalités supplémentaires:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                '1. Authentification sécurisée.\n'
                    '2. Interface utilisateur fluide et intuitive.\n'
                    '3. Accès rapide aux fonctionnalités principales.\n'
                    '4. Support multilingue pour une meilleure expérience utilisateur.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              Text(
                'À propos de Flutter:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Flutter est un framework open-source développé par Google pour créer des applications mobiles, web et de bureau à partir d\'une seule base de code.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Copyright and legal text (optional)
              Center(
                child: Text(
                  '© 2024 Yang-Bao. Tous droits réservés.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.green, // Text color changed to green
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}