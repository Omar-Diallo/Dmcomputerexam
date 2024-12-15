import 'package:flutter/material.dart';

import 'menu_screen.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>MenuScreen()));
            },
            icon: Icon(Icons.arrow_back, size: 30,)),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Mes Favoris',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [

                SizedBox(height: 300,),

                Text('Aucun produit favori', style: TextStyle(fontSize: 20, color: Colors.grey),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}