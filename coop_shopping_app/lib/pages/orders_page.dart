import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coop_shopping_app/firebase/firebase_service.dart';
import 'package:coop_shopping_app/global/order_model.dart';
import 'package:coop_shopping_app/global/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final FirebaseService _firebaseService = FirebaseService();
  late User? _user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _user = _firebaseService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('orders')
            .where('userId', isEqualTo: _user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching orders: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            final List<MyOrder> orders = snapshot.data!.docs
                .map((doc) => MyOrder.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return _buildOrderList(orders);
          }
        },
      ),
    );
  }

  Widget _buildOrderList(List<MyOrder> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final MyOrder order = orders[index];
        return ListTile(
          title: Text(order.productName),
          subtitle: Text('Price: ${order.price}'),
          trailing: ElevatedButton(
            onPressed: () => _reorderItem(order),
            child: const Text('Reorder'),
          ),
        );
      },
    );
  }

  Future<void> _reorderItem(MyOrder order) async {
    // Implement your logic for reordering an item
    // You can use the order details to create a new order or take any other actions
    showToast( 'Reordering item: ${order.productName}');

    // Show a toast or any feedback to the user
    showToast("Reordering ${order.productName}");
  }
}
