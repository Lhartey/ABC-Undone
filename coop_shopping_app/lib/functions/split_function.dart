import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartItem {
  String productName;
  int quantity; // For quantity-based split
  double totalWeight; // For weight-based split
  bool isSplitByWeight;

  CartItem({
    required this.productName,
    required this.quantity,
    required this.totalWeight,
    required this.isSplitByWeight,
  });
}

void splitOrder(BuildContext context, CartItem cartItem) {
  if (cartItem.isSplitByWeight) {
    // Split by weight logic
    double weightPerItem = cartItem.totalWeight / cartItem.quantity;
    Fluttertoast.showToast(
      msg: 'Splitting ${cartItem.productName} by weight:\nEach item: $weightPerItem kg',
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  } else {
    // Split by quantity logic
    Fluttertoast.showToast(
      msg: 'Splitting ${cartItem.productName} by quantity:\nEach item: ${cartItem.quantity}',
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}

Future<void> showSplitDialog(
  BuildContext context,
  void Function(int quantity) onSplit,
  int totalQuantity,
) async {
  int? splitValue = await showDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Split'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (totalQuantity <= 10) // Show pop-up menu for small quantity
              Column(
                children: List.generate(
                  totalQuantity,
                  (index) => ListTile(
                    title: Text((index + 1).toString()),
                    onTap: () => Navigator.of(context).pop(index + 1),
                  ),
                ),
              )
            else // Show a scrollable pop-up menu for larger quantity
              SizedBox(
                height: 200, // Set the desired height
                child: ListView.builder(
                  itemCount: totalQuantity,
                  itemBuilder: (context, index) => ListTile(
                    title: Text((index + 1).toString()),
                    onTap: () => Navigator.of(context).pop(index + 1),
                  ),
                ),
              ),
            if (totalQuantity > 10) // Show text input for large quantity
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter quantity',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    int parsedValue = int.tryParse(value) ?? 1;
                    if (parsedValue > totalQuantity) {
                      Fluttertoast.showToast(
                        msg: 'Quantity exceeds available stock.',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_LONG,
                      );
                    } else {
                      Navigator.of(context).pop(parsedValue);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    ),
  );

  if (splitValue != null) {
    onSplit(splitValue);
  }
}
