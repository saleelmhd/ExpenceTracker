// Assuming you have a function to update the business name in Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> updateBusinessName(String userId, String newBusinessName) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'businessName': newBusinessName});
  } catch (e) {
    print('Error updating business name: $e');
    // Handle error
  }
}

// Widget for editing business name page
class EditBusinessNamePage extends StatefulWidget {
  final String userId;

  EditBusinessNamePage({required this.userId});

  @override
  _EditBusinessNamePageState createState() => _EditBusinessNamePageState();
}

class _EditBusinessNamePageState extends State<EditBusinessNamePage> {
  late TextEditingController _businessNameController;

  @override
  void initState() {
    super.initState();
    _businessNameController = TextEditingController();
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    super.dispose();
  }

  void _submit() {
    String newBusinessName = _businessNameController.text.trim();
    if (newBusinessName.isNotEmpty) {
      updateBusinessName(widget.userId, newBusinessName);
      // Optionally, you can navigate back to the previous page or show a success message.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'Business Name',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter new business name:'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _businessNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'New Business Name',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: const LinearBorder(),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white),
              onPressed: (){
                _submit();
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
