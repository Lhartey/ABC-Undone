import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:coop_shopping_app/widgets/product_card.dart';

class ProductsCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 215,
        enlargeCenterPage: true,
        pauseAutoPlayOnManualNavigate: true,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: products.map((product) {
        return ProductCard(
          title: product['title'] as String,
          price: product['price'] as double,
          image: product['imageUrl'] as String,
          backgroundColor: Colors.grey, // Set your desired background color here,
        );
      }).toList(),
    );
  }
}