import 'package:coop_shopping_app/pages/cart_page.dart';
import 'package:coop_shopping_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int splitQuantity = 1;
  int generalQuantity = 1;
  bool isSplitOrder = false;

  void onTap() {
    Provider.of<CartProvider>(context, listen: false).addproduct(
      {
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'Brand': widget.product['Brand'],
        'quantity': isSplitOrder ? splitQuantity : generalQuantity,
        'orderType': isSplitOrder ? 'Split Order' : 'Bulk Order',
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product Added'),
      ),
    );
  }

  void onGeneralQuantity() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController quantityController =
            TextEditingController(text: generalQuantity.toString());

        return AlertDialog(
          title: const Text('Select Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (generalQuantity > 1) {
                          generalQuantity--;
                          generalQuantity.toString();
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$generalQuantity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        generalQuantity++;
                        quantityController.text = generalQuantity.toString();
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void onSplit() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 100, 100),
      items: List.generate(
        10,
        (index) => PopupMenuItem(
          value: index + 1,
          child: Text((index + 1).toString()),
        ),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          splitQuantity = value;
          generalQuantity = 1;
          isSplitOrder = true;
        });
        onTap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.product['title'] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                height: 250,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 247, 249, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GH¢${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            );
                            setState(() {
                              if (generalQuantity > 1) {
                                generalQuantity--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            ' $generalQuantity',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              generalQuantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton.icon(
                        onPressed: onSplit,
                        icon: const Icon(Icons.splitscreen),
                        label: const Text(
                          'Split',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fixedSize: const Size(350, 50),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          onTap();
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text(
                          'Add To Cart',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fixedSize: const Size(350, 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
