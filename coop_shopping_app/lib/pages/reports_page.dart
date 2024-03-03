import 'package:coop_shopping_app/global/toast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ReportProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> submitReport() async {
    try {
      await FirebaseFirestore.instance.collection('reports').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear text fields after successful submission
      titleController.clear();
      descriptionController.clear();
      notifyListeners();
    } catch (error) {
      throw Exception('Error submitting report: $error');
    }
  }
}

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: reportProvider.titleController,
              decoration: const InputDecoration(labelText: 'Report Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reportProvider.descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Report Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await reportProvider.submitReport();
                showToast( 'Report submitted successfully!');
              },
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
