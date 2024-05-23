import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionPay extends StatefulWidget {
  final String name;
  final String docid;
  final String userId;
  final bool isGaveSelected;

  TransactionPay(
      {Key? key,
      required this.isGaveSelected,
      required this.name,
      required this.userId,
      required this.docid})
      : super(key: key);

  @override
  State<TransactionPay> createState() => _TransactionPayState();
}

class _TransactionPayState extends State<TransactionPay> {
  TextEditingController controllerGave = TextEditingController();
  TextEditingController controllerGot = TextEditingController();
  late String titleText;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Add listeners to both controllers to update the title
    controllerGave.addListener(updateTitleText);
    controllerGot.addListener(updateTitleText);
    // Initialize the title
    updateTitleText();
  }

  void addToGaveCollection(String amount) {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the main collection for users
    CollectionReference users = firestore.collection('users');

    // Reference to the subcollection for customers under a specific user
    CollectionReference customers =
        users.doc('${widget.userId}').collection('Customers');

    // Add the amount to the customer's "youGave" subcollection
    customers.doc('${widget.docid}').collection('youGave').add({
      'amount': double.parse(amount), // Convert amount to double
      'timestamp':
          FieldValue.serverTimestamp(), // Use Firestore server timestamp
      'custNames': widget.name,
    }).then((value) {
      // Transaction added successfully
      print('Transaction added successfully');
    }).catchError((error) {
      // Error handling
      print('Failed to add transaction: $error');
    });
  }

  void addToGotCollection(String amount) {
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the main collection for users
    CollectionReference users = firestore.collection('users');

    // Reference to the subcollection for customers under a specific user
    CollectionReference customers =
        users.doc('${widget.userId}').collection('Customers');

    // Add the amount to the customer's "youGave" subcollection
    customers.doc('${widget.docid}').collection('youGot').add({
      'amount': double.parse(amount), // Convert amount to double
      'timestamp':
          FieldValue.serverTimestamp(), // Use Firestore server timestamp
      'custNames': widget.name,
    }).then((value) {
      // Transaction added successfully
      print('Transaction added successfully');
    }).catchError((error) {
      // Error handling
      print('Failed to add transaction: $error');
    });
  }
  // void addToGotCollection(String amount) {
  //   // Get a reference to the Firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Reference to the collection for customers
  //   CollectionReference customers = firestore.collection('Customers');

  //   // Add the amount to the customer's collection
  //   customers.doc('${widget.docid}').collection('youGot').add({
  //     'amount': amount,
  //     'timestamp': DateTime
  //         .now(), // Optional: You can add a timestamp for the transaction
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
      titleText = widget.isGaveSelected
          ? "Give Money .${widget.name} ₹ ${controllerGave.text}"
          : "Get Money . ${widget.name} ₹ ${controllerGot.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: widget.isGaveSelected ? Colors.red : Colors.green,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          titleText,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.isGaveSelected
                  ? TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },
                      controller: controllerGave,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusColor: Colors.greenAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        prefixIcon:
                            Icon(Icons.currency_rupee, color: Colors.red),
                        hintText: ' Enter amount',
                      ),
                    )
                  : TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },
                      controller: controllerGot,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusColor: Colors.greenAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        prefixIcon:
                            Icon(Icons.currency_rupee, color: Colors.green),
                        hintText: ' Enter amount',
                      ),
                    ),
              widget.isGaveSelected
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, continue processing
                              String amount = controllerGave.text;

                              // Assuming you have the customer's document I

                              // Add the amount to the customer's collection
                              addToGaveCollection(amount);

                              // Clear the text field after adding the transaction
                              controllerGave.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              color: Colors.red.shade300,
                            ),
                            child: const Text('Save',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                  : Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, continue processing
                              String amount = controllerGot.text;
                              addToGotCollection(amount);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              color: Colors.green.shade300,
                            ),
                            child: const Text('Save',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class TransactionPay extends StatefulWidget {
//   String name;
//   final bool isGaveSelected;
//
//   TransactionPay({Key? key, required this.isGaveSelected,required this.name}) : super(key: key);
//
//   @override
//   State<TransactionPay> createState() => _TransactionPayState();
// }
//
// class _TransactionPayState extends State<TransactionPay> {
//   TextEditingController controllerGave=TextEditingController();
//   TextEditingController controllerGot=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 2,
//         foregroundColor: widget.isGaveSelected ? Colors.red : Colors.green,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title:
//         widget.isGaveSelected == true
//             // ? Text("Give Money .${widget.name}${controllerGave.text}", style: TextStyle(fontSize: 16),)
//             // : Text("Get Money . ${widget.name}${controllerGot.text}", style: TextStyle(fontSize: 16),),
//             ? Text("Give Money .${widget.name}${controllerGave.text}", style: TextStyle(fontSize: 16),)
//             : Text("Get Money . ${widget.name}${controllerGot.text}", style: TextStyle(fontSize: 16),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             widget.isGaveSelected ==true?
//             TextFormField(
//               controller: controllerGave,
//               keyboardType: TextInputType.number, // Set keyboard type to numeric
//               decoration: const InputDecoration(
//                 focusColor: Colors.greenAccent,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   borderSide: BorderSide(color: Colors.red), // Set border color to red
//                 ),
//                 prefixIcon: Icon(Icons.currency_rupee,color: Colors.red,),
//                 hintText: ' Enter amount',
//               ),
//             ): TextFormField(
//               controller: controllerGot,
//               keyboardType: TextInputType.number, // Set keyboard type to numeric
//               decoration: const InputDecoration(
//
//                 focusColor: Colors.greenAccent,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   borderSide: BorderSide(color: Colors.red), // Set border color to red
//                 ),
//                 prefixIcon: Icon(Icons.currency_rupee,color: Colors.green,),
//                 hintText: ' Enter amount',
//               ),
//             ),
//             widget.isGaveSelected ==true?
//             Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration:  ShapeDecoration(shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(4)
//                     ),
//                   ),
//                       color: Colors.red.shade300
//                   ),
//                   child: const Text('Save',style: TextStyle(color: Colors.white),),
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             ):
//             Column(
//               children: [
//                 InkWell(onTap: (){
//                   print("pppppp5555555555${controllerGave.text}");
//                 },
//                   child: Container(
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration:  ShapeDecoration(shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)
//                       ),
//                     ),
//                         color: Colors.green.shade300
//                     ),
//                     child: const Text('Save',style: TextStyle(color: Colors.white),),
//                   ),
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }