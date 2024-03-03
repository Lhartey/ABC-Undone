import 'package:coop_shopping_app/global/toast.dart';
import 'package:coop_shopping_app/pages/orders_page.dart';
import 'package:coop_shopping_app/pages/profile_page.dart';
import 'package:coop_shopping_app/pages/reports_page.dart';
import 'package:coop_shopping_app/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:coop_shopping_app/global/global_variables.dart';
import 'package:coop_shopping_app/widgets/product_card.dart';
import 'package:coop_shopping_app/pages/product_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Rice & Spaghetti',
    'Cooking Oil',
    'Poultry (Imported)',
    'Fish (Imported)',
    'Sea Food (Imported)',
    'Vegetables (Imported)',
    'Fresh Meat (Local)',
    'Potato Chips',
    'Cheese & Cream',
    'Butter',
    'UHT Milk/Juice',
    'Pantry Goods',
    'Household Items',
  ];

  late String selectedFilter;
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    filterProducts();
  }

  void filterProducts() {
    if (selectedFilter == 'All') {
      filteredProducts = List<Map<String, Object>>.from(products);
    } else {
      filteredProducts = List<Map<String, Object>>.from(
        products.where((product) => product['category'] == selectedFilter),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Accra Buyers Club',
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showToast('Search functionality is not implemented yet.');
            },
            alignment: Alignment.topRight,
          ),
        ],
        backgroundColor: Colors.blue, // Change to your desired color
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue, // Change to your desired color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            buildDrawerItem(Icons.account_circle, 'Profile', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }),
            buildDrawerItem(Icons.shopping_cart, 'Orders', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersPage()),
              );
            }),
            buildDrawerItem(Icons.report, 'Report', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
            }),
          ],
        ),
      ),

      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                            filterProducts();
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(245, 247, 249, 1),
                          side: const BorderSide(
                            color: Color.fromRGBO(246, 248, 249, 1),
                          ),
                          label: Text(filter),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const MyCarousel(),
              if (size.width > 650)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  gridDelegate: size.width > 920
                      ? const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                        )
                      : const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                        ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(
                                product: filteredProducts[index]
                                    as Map<String, Object>,
                              );
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(254, 255, 117, 1)
                            : const Color.fromRGBO(255, 63, 129, 162),
                      ),
                    );
                  },
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(
                                product: filteredProducts[index]
                                    as Map<String, Object>,
                              );
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(254, 255, 117, 1)
                            : const Color.fromARGB(255, 63, 129, 162),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
   Widget buildDrawerItem(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}