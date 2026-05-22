import 'package:flutter/material.dart';

void main() {
  runApp(AshStoreApp());
}

class AshStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ash Store',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class Product {
  final String name;
  final int price;

  Product(this.name, this.price);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product("Phone", 15000),
    Product("Shoes", 2500),
    Product("Watch", 1200),
    Product("Bag", 1800),
  ];

  List<Product> cart = [];

  void addToCart(Product p) {
    setState(() {
      cart.add(p);
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  int get totalPrice {
    return cart.fold(0, (sum, item) => sum + item.price);
  }

  void checkout() {
    setState(() {
      cart.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order placed successfully (Demo)")),
    );
  }

  void showCart() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Your Cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cart[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("৳${cart[index].price}"),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              removeFromCart(index);
                              Navigator.pop(context);
                              showCart();
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text("Total: ৳$totalPrice", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: checkout,
                child: Text("Checkout"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ash Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: showCart,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            return Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag, size: 50, color: Colors.indigo),
                  SizedBox(height: 10),
                  Text(p.name, style: TextStyle(fontSize: 18)),
                  Text("৳${p.price}"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => addToCart(p),
                    child: Text("Add to Cart"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
