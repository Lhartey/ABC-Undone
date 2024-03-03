import 'package:coop_shopping_app/global/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;

  const CheckoutScreen({super.key, required this.total});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Checkout', style: textTheme.headlineMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Insert your card details',
                style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Text('Total: GH¢${widget.total.toStringAsFixed(2)}'),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: loading ? null : () => handlePayment(context),
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handlePayment(BuildContext context) async {
    setState(() {
      loading = true;
    });

    try {
      await initiatePayment();
    } catch (err) {
      showToast( 'Payment failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> initiatePayment() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Handle the case where the user is not logged in
      showToast( 'User not logged in');
      return;
    }

    String userEmail = currentUser.email!;
    
    // Example: Using PayWithPayStack
    PayWithPayStack().now(
      context: context,
      secretKey: "sk_test_ec79ff83d20dbe710badeca6d393eeedad2af070",
      customerEmail: userEmail,
      reference: DateTime.now().microsecondsSinceEpoch.toString(),
      callbackUrl: "setup in your paystack dashboard",
      currency: "GHS",
      paymentChannel: ["mobile_money", "card"],
      amount: (widget.total * 100).toString(),
      transactionCompleted: () {
        // Define your payment data here
        const payMentData = {'status': 'success', 'amount': '1000'};
        
        Navigator.pop(context, payMentData);
        showToast( "Transaction Successful");
        // Navigate back to the previous page when the transaction is successful
        Navigator.pop(context);
      },
      transactionNotCompleted: () {
        showToast( "Transaction Not Successful!");
      },
      metaData: {"cancel_action": "https://your-cancel-url.com"},
    );
  }
}
