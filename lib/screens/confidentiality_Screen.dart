import 'package:flutter/material.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({super.key});

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
          'Confidentialité',
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
              // Title and introduction
              Text(
                'Politique de Confidentialité',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Dernière mise à jour: Décembre 2024',
                style: TextStyle(fontSize: 14, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Introduction to the policy
              Text(
                'Nous respectons votre vie privée et nous nous engageons à protéger vos informations personnelles. '
                    'Cette politique de confidentialité explique quelles données nous collectons, comment elles sont utilisées, '
                    'et comment nous les protégeons.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Types of data collected
              Text(
                '1. Données collectées',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Lorsque vous utilisez notre application, nous pouvons collecter des informations personnelles, telles que :\n'
                    '- Yang - Bao\n'
                    '- yang@gmail.com\n'
                    '- Informations de connexion\n'
                    '- Adresse IP et informations de localisation\n',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Purpose of data collection
              Text(
                '2. Utilisation des données',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Les informations que nous collectons sont utilisées pour :\n'
                    '- Fournir et améliorer nos services\n'
                    '- Assurer la sécurité de l\'application\n'
                    '- Répondre aux demandes et offrir un support utilisateur\n',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Data protection
              Text(
                '3. Protection des données',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Nous mettons en place des mesures de sécurité pour protéger vos données personnelles contre toute perte, '
                    'utilisation abusive ou accès non autorisé. Cependant, aucun système de sécurité n\'est totalement infaillible.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Third-party sharing
              Text(
                '4. Partage avec des tiers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Nous ne partageons pas vos informations personnelles avec des tiers, sauf si cela est nécessaire pour fournir '
                    'nos services ou si nous y sommes obligés par la loi.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Cookies policy
              Text(
                '5. Politique relative aux cookies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Notre application utilise des cookies pour améliorer votre expérience. Vous pouvez choisir de désactiver les cookies dans les paramètres de votre appareil.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // User rights
              Text(
                '6. Vos droits',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Conformément à la législation sur la protection des données, vous avez le droit d\'accéder, de corriger, '
                    'et de supprimer vos informations personnelles. Si vous souhaitez exercer ces droits, veuillez nous contacter.',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),

              // Contact information
              Text(
                '7. Contactez-nous',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green, // Text color changed to green
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Si vous avez des questions concernant cette politique de confidentialité, n\'hésitez pas à nous contacter à l\'adresse suivante :\n'
                    'Email: privacy@example.com',
                style: TextStyle(fontSize: 16, color: Colors.green), // Text color changed to green
              ),
              SizedBox(height: 20),


              Center(
                child: Text(
                  '© 2024 Yang - Bao\'Application. Tous droits réservés.',
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