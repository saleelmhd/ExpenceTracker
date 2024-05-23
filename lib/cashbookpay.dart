import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CashbookPay extends StatefulWidget {
  final String name;
  final bool isOutSelected;
  String userId;

  CashbookPay({
    Key? key,
    required this.isOutSelected,
    required this.name,
    required this.userId
  }) : super(key: key);

  @override
  State<CashbookPay> createState() => _CashbookPayState();
}

class _CashbookPayState extends State<CashbookPay> {
  TextEditingController controllerOut = TextEditingController();
  TextEditingController controllerIn = TextEditingController();
  late String titleText;

  @override
  void initState() {
    super.initState();
    // Add listeners to both controllers to update the title
    controllerOut.addListener(updateTitleText);
    controllerIn.addListener(updateTitleText);
    // Initialize the title
    updateTitleText();
  }

   void addToOUTCollection(String amount) {
  // Get a reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Reference to the main collection for users
  CollectionReference users = firestore.collection('users');

  // Reference to the subcollection for customers under a specific user
  // CollectionReference customers = users.doc('${widget.userId}').collection('Customers');

  // Add the amount to the customer's "youGave" subcollection
  users.doc('${widget.userId}').collection('OUT').add({
    'amount': double.parse(amount), // Convert amount to double
    'timestamp': FieldValue.serverTimestamp(), // Use Firestore server timestamp
  }).then((value) {
    // Transaction added successfully
    print('Transaction added successfully');
  }).catchError((error) {
    // Error handling
    print('Failed to add transaction: $error');
  });
}
 void addToINCollection(String amount) {
  // Get a reference to the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Reference to the main collection for users
  CollectionReference users = firestore.collection('users');

  // Reference to the subcollection for customers under a specific user
  // CollectionReference customers = users.doc('${widget.userId}').collection('Customers');

  // Add the amount to the customer's "youGave" subcollection
  users.doc('${widget.userId}').collection('IN').add({
    'amount': double.parse(amount), // Convert amount to double
    'timestamp': FieldValue.serverTimestamp(), // Use Firestore server timestamp
  }).then((value) {
    // Transaction added successfully
    print('Transaction added successfully');
  }).catchError((error) {
    // Error handling
    print('Failed to add transaction: $error');
  });
}

  // void addToGotCollection(String amount) {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference customers = firestore.collection('Customers');

  //   customers.doc('kwCJzL529W8MXug0ASmz').collection('cashIn').add({
  //     'amount': amount,
  //     'timestamp': DateTime.now(),
  //   }).then((value) {
  //     // Transaction added successfully
  //     print('Transaction added successfully');
  //   }).catchError((error) {
  //     // Error handling
  //     print('Failed to add transaction: $error');
  //   });
  // }

  void updateTitleText() {
    setState(() {
      titleText = widget.isOutSelected
          ? "Out Entry ${widget.name} ${controllerOut.text}"
          : "In Entry ${widget.name} ${controllerIn.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: widget.isOutSelected ? Colors.red : Colors.green,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          titleText,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isOutSelected
                ? TextFormField(
                    controller: controllerOut,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.red),
                      hintText: 'Enter amount',
                    ),
                  )
                : TextFormField(
                    controller: controllerIn,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.green),
                      hintText: 'Enter amount',
                    ),
                  ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                String amount = widget.isOutSelected
                    ? controllerOut.text.trim()
                    : controllerIn.text.trim();

                if (amount.isNotEmpty) {
                  if (widget.isOutSelected) {
                    addToOUTCollection(amount);
                  } else {
                    addToINCollection(amount);
                  }

                  // Clear the text field after adding the transaction
                  controllerOut.clear();
                  controllerIn.clear();

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                } else {
                  // Show an error message if amount is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid amount.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: widget.isOutSelected
                      ? Colors.red.shade300
                      : Colors.green.shade300,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}