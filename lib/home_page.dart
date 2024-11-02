import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [
    Product(id: '1', title: 'Dumpling', price: 'Rp23.000', imageUrl: 'images/dumpling.jpg'),
    Product(id: '2', title: 'Pizza', price: 'Rp15.000', imageUrl: 'images/pizza.jpg'),
    Product(id: '3', title: 'Burger', price: 'Rp11.000', imageUrl: 'images/burger.jpg'),
    Product(id: '4', title: 'Sushi', price: 'Rp20.000', imageUrl: 'images/sushi.jpg'),
  ];

  // Fungsi untuk menambahkan produk baru
  void _addProduct(String title, String price, String imageUrl) {
    setState(() {
      _products.add(
        Product(id: DateTime.now().toString(), title: title, price: price, imageUrl: imageUrl),
      );
    });
  }

  // Fungsi untuk mengedit produk
  void _editProduct(String id, String newTitle, String newPrice, String newImageUrl) {
    setState(() {
      final index = _products.indexWhere((product) => product.id == id);
      if (index != -1) {
        _products[index] = Product(id: id, title: newTitle, price: newPrice, imageUrl: newImageUrl);
      }
    });
  }

  // Fungsi untuk menghapus produk
  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  // Dialog untuk menambahkan atau mengedit produk
  void _showProductDialog({Product? product}) {
    final TextEditingController titleController = TextEditingController(text: product?.title ?? '');
    final TextEditingController priceController = TextEditingController(text: product?.price ?? '');
    final TextEditingController imageUrlController = TextEditingController(text: product?.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? 'Tambah Produk' : 'Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Harga Produk'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (product == null) {
                _addProduct(titleController.text, priceController.text, imageUrlController.text);
              } else {
                _editProduct(product.id, titleController.text, priceController.text, imageUrlController.text);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(product == null ? 'Tambah' : 'Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/profil1.jpg'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hallo, Indra Kusuma'),
                Text('Selamat Pagi.', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _products.length,
        itemBuilder: (ctx, i) {
          final product = _products[i];
          return ListTile(
            leading: Image.asset(product.imageUrl),
            title: Text(product.title),
            subtitle: Text(product.price),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showProductDialog(product: product),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(product.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}
