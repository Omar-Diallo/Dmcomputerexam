import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Page Profil', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
