import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'carousel_screen.dart';
import 'connexion_screen.dart';
import 'drawer_screen.dart';
import 'menu_screen.dart';
import 'panier_screen.dart';
import 'recherche_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMComputer.sn',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuScreen(),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final double price;
  final String description;
  bool isFavorite;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;
  bool isLoading = false;
  List<Product> products = [];
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchProducts({int categoryId = 0}) async {
    String url = 'https://dmcomputer.sn/wp-json/wc/v3/products';
    if (categoryId > 0) {
      url += '?category=$categoryId';
    }

    setState(() {
      isLoading = true; // Démarrer le chargement
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
          products = productsData.map((product) {
            return Product(
              imageUrl: product['images'][0]['src'],
              name: product['name'],
              price: double.parse(product['price']),
              description: product['description'],
            );
          }).toList();
          isLoading = false; // Terminer le chargement
        });
      } else {
        throw Exception('Échec du chargement des produits');
      }
    } catch (e) {
      print("Erreur lors de la récupération des produits: $e");
      showErrorDialog(context, "Échec du chargement des produits. Veuillez réessayer plus tard.");
      setState(() {
        isLoading = false; // Terminer le chargement même en cas d'erreur
      });
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://dmcomputer.sn/wp-json/wc/v3/products/categories'),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> categoriesData = json.decode(response.body);
        setState(() {
          categories = categoriesData;
        });
        if (categories.isNotEmpty) {
          fetchProducts(categoryId: categories[0]['id']);
        }
      } else {
        throw Exception('Échec du chargement des catégories');
      }
    } catch (e) {
      print("Erreur lors de la récupération des catégories: $e");
      showErrorDialog(context, "Échec du chargement des catégories. Veuillez réessayer plus tard.");
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  double calculateChildAspectRatio(int crossAxisCount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth = screenWidth / crossAxisCount;
    final itemHeight = itemWidth * 1.5; // Ajuster la hauteur selon vos besoins
    return itemWidth / itemHeight;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageList = [
      Image.asset('images/p1.jpg', width: 300, height: 100),
      Image.asset('images/p2.jpg', width: 300, height: 100),
      Image.asset('images/p3.jpg', width: 300, height: 100),
    ];

    final buttonTitles = ['Tout', 'Accessoire Informatique', 'Batteries Ordinateurs', 'Imprimantes & Consommables', 'Multimedia', 'Onduleurs'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('DMComputer.sn', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanierScreen()));
            },
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerScreen(),
      body: ClipRect(
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              SimpleCarousel(items: imageList),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Catégories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Voir tout', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              DynamicButtonList(
                buttonTitles: buttonTitles,
                onButtonPressed: (index) {
                  if (index == 0) {
                    fetchProducts();
                  } else {
                    fetchProducts(categoryId: categories[index - 1]['id']);
                  }
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: calculateChildAspectRatio(2),
                  children: products.map((product) => _buildProductCard(product)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (_selectedIndex == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuScreen()));
          }
          if (_selectedIndex == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RechercheSceeen()));
          }
          if (_selectedIndex == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PanierScreen()));
          }
          if (_selectedIndex == 3) {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ConnexionScreen()));
          }
          print(_selectedIndex);
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 100,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      product.isFavorite = !product.isFavorite;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                '${product.price} FCFA',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ConnexionScreen extends StatefulWidget {
  @override
  _ConnexionScreenState createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulation de la connexion (remplacer par la véritable logique de connexion)
    await Future.delayed(Duration(seconds: 2));

    // Enregistrer les informations de l'utilisateur dans les SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    // Naviguer vers l'écran MenuScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Connexion', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Adresse email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    // Logique pour obtenir une instance des SharedPreferences
    return SharedPreferences._internal();
  }

  SharedPreferences._internal();

  Future<bool> setString(String key, String value) async {
    // Logique pour enregistrer une chaîne de caractères dans les SharedPreferences
    return true;
  }

  Future<String?> getString(String key) async {
    // Logique pour récupérer une chaîne de caractères dans les SharedPreferences
    return null;
  }

// Vous pouvez ajouter d'autres méthodes comme setInt, setBool, etc.
}

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('john.doe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () {
              // Naviguer vers l'écran de profil
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Panier'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PanierScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            onTap: () {
              // Déconnecter l'utilisateur et le rediriger vers l'écran de connexion
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConnexionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PanierScreen extends StatefulWidget {
  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Panier', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: cart.isEmpty
          ? Center(
        child: Text('Votre panier est vide'),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.network(
                  cart[index].imageUrl,
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${cart[index].price} FCFA',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    removeFromCart(cart[index]);
                  },
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Ajouter la logique de paiement
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text('Passer à la caisse'),
          ),
        ),
      ),
    );
  }
}

class RechercheSceeen extends StatefulWidget {
  @override
  _RechercheSceeenState createState() => _RechercheSceeenState();
}

class _RechercheSceeenState extends State<RechercheSceeen> {
  final _searchController = TextEditingController();
  List<Product> searchResults = [];

  void _searchProducts() async {
    String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('https://dmcomputer.sn/wp-json/wc/v3/products?search=$searchTerm'),
          headers: {
            'Authorization': 'Basic ${base64Encode(utf8.encode("ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35"))}',
          },
        );

        if (response.statusCode == 200) {
          List<dynamic> productsData = json.decode(response.body);
          setState(() {
            searchResults = productsData.map((product) {
              return Product(
                imageUrl: product['images'][0]['src'],
                name: product['name'],
                price: double.parse(product['price']),
                description: product['description'],
              );
            }).toList();
          });
        } else {
          throw Exception('Échec de la recherche de produits');
        }
      } catch (e) {
        print("Erreur lors de la recherche de produits: $e");
        showErrorDialog(context, "Échec de la recherche de produits. Veuillez réessayer plus tard.");
      }
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Recherche', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onSubmitted: (value) {
                _searchProducts();
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un produit',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchProducts,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: searchResults.isEmpty
                  ? Center(child: Text('Aucun résultat trouvé'))
                  : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: searchResults.map((product) => _buildProductCard(product)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: [
          Image.network(
            product.imageUrl,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '${product.price} FCFA',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SimpleCarousel extends StatefulWidget {
  final List<Widget> items;

  SimpleCarousel({required this.items});

  @override
  _SimpleCarouselState createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return widget.items[index];
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.items.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _pageController.animateToPage(entry.key,
                  duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ? Colors.green : Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DynamicButtonList extends StatefulWidget {
  final List<String> buttonTitles;
  final void Function(int) onButtonPressed;

  DynamicButtonList({
    required this.buttonTitles,
    required this.onButtonPressed,
  });

  @override
  _DynamicButtonListState createState() => _DynamicButtonListState();
}

class _DynamicButtonListState extends State<DynamicButtonList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.buttonTitles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onButtonPressed(index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedIndex == index ? Colors.green : Colors.grey[300],
                foregroundColor: _selectedIndex == index ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(widget.buttonTitles[index]),
            ),
          );
        },
      ),
    );
  }
}