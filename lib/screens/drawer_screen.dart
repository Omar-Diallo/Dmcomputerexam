//import 'package:dmcomputer/screens/connexion_screen.dart';
//import 'package:dmcomputer/screens/panier_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'apropos_screen.dart';
import 'confidentiality_Screen.dart';
import 'favoris_screen.dart';
import 'panier_screen.dart';
import 'recherche_screen.dart';
//import 'recherche_sceeen.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),  // Supprimer le padding autour du Header
              child: Image(
                image: AssetImage('images/logo.jpg'),
                width: 200,
                height: 70,
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
              ),

            ),


            ListTile(
              leading: Icon(Icons.home,),
              title: Text("Accueil", style: TextStyle(color: Colors.black)),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border,),
              title: Text("Favoris", style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FavorisScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.search,),
              title: Text("Recherche", style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RechercheSceeen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart,),
              title: Text("Panier", style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PanierScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.share_outlined,),
              title: Text("Partager", style: TextStyle(color: Colors.black)),
              onTap: () {
                _showSharePopup(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person,),
              title: Text("Mon compte", style: TextStyle(color: Colors.black)),
              onTap: () {
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ConnexionScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info,),
              title: Text("A propos", style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AproposScreen()),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.lock,),  // Autre icône personnalisée
              title: Text("Politique de confidentialité", style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfidentialityScreen()),
                );

              },
            ),
            ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lorsque le bouton est pressé
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.login, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Deconnexion',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ),
                )

            ),

          ],
        ),
      ),
    );

  }
}


void _showSharePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Partager'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Partager le texte'),
              onTap: () {
                Navigator.pop(context);
                _shareText(); // Trigger the sharing of text
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('Partager un lien'),
              onTap: () {
                Navigator.pop(context);
                _shareLink(); // Trigger the sharing of a link
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.whatsapp),
              title: Text('Partager via WhatsApp'),
              onTap: () {
                Navigator.pop(context);
                _shareViaWhatsApp(); // Trigger WhatsApp sharing
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Partager via Messenger'),
              onTap: () {
                Navigator.pop(context);
                _shareViaMessenger(); // Trigger Messenger sharing
              },
            ),
          ],
        ),
      );
    },
  );
}

// Function to share some text with Share Plus
void _shareText() {
  Share.share('Regardez cette application Flutter incroyable!');
}

// Function to share a link with Share Plus
void _shareLink() {
  Share.share('Check out this awesome app: https://www.example.com');
}

// Function to share text via WhatsApp
void _shareViaWhatsApp() async {
  String message = 'Regardez cette application Flutter incroyable!'; // Text to share
  String url = 'https://wa.me/?text=$message';

  if (await canLaunch(url)) {
    await launch(url); // Open WhatsApp with the pre-filled message
  } else {
    print('WhatsApp is not installed or unable to open.');
  }
}

// Function to share text via Messenger
void _shareViaMessenger() async {
  String message = 'Regardez cette application Flutter incroyable!'; // Text to share
  String url = 'fb-messenger://share?text=$message';

  if (await canLaunch(url)) {
    await launch(url); // Open Messenger with the pre-filled message
  } else {
    print('Messenger is not installed or unable to open.');
  }
}