// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../core/globel_variable.dart';
// import '../viewreport/entry_details.dart';
// import 'gave&got_transaction.dart';

// class Transaction extends StatefulWidget {
//   String name;
//   String number;
//   String customerId;
//   Transaction({
//     super.key,
//     required this.name,
//     required this.number,
//     required this.customerId,
//   });

//   @override
//   State<Transaction> createState() => _TransactionState();
// }

// class _TransactionState extends State<Transaction> {
//   double? netAmount = 0.0;
//   bool isGaveSelected = false;
//   Color myColor = Colors.red;
//   Color myColor1 = Colors.green;
//   late List<Map<String, dynamic>>
//       transactions; // List to store transaction data

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8))),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => TransactionPay(
//                             docid: widget.customerId,
//                             isGaveSelected: isGaveSelected = true,
//                             name: widget.name,
//                           )),
//                 );
//               },
//               child: const Text("YOU GAVE ₹"),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green.shade700,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8))),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => TransactionPay(
//                             isGaveSelected: isGaveSelected = false,
//                             name: widget.name,
//                             docid: widget.customerId,
//                           )),
//                 );
//               },
//               child: const Text("YOU GOT ₹"),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         title: Row(
//           children: [
//             CircleAvatar(
//                 backgroundColor:
//                     Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
//                         .withOpacity(1.0),
//                 child: Text(
//                   widget.name.substring(0, 1),
//                   style: const TextStyle(color: Colors.white),
//                 )),
//             Text(
//               "  ${widget.name}",
//               style: const TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//         actions: const [
//           Icon(
//             Icons.more_vert,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.indigo.shade600,
//               width: double.infinity,
//               height: 60,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: StreamBuilder<DocumentSnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('Customers')
//                           .doc(widget.customerId)
//                           .snapshots(),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<DocumentSnapshot> snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         }
//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }

//                         // Get the customer document data
//                         var customerData =
//                             snapshot.data!.data() as Map<String, dynamic>?;

//                         // Check if the document exists and contains the netAmount
//                         if (customerData != null &&
//                             customerData.containsKey('netAmount')) {
//                           double netAmount = customerData['netAmount'];
//                           return Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   netAmount == 0.0
//                                       ? const Text("Settled up")
//                                       : netAmount < 0.0
//                                           ? const Text(
//                                               "You will give",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             )
//                                           : const Text(
//                                               "You will get",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                   Icon(
//                                     netAmount < 0.0
//                                         ? Icons.emoji_emotions
//                                         : Icons.emoji_emotions_outlined,
//                                     color: netAmount < 0.0
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ],
//                               ),
//                               netAmount == 0.0
//                                   ? const Text("0")
//                                   : netAmount < 0.0
//                                       ? Text(
//                                           '${netAmount < 0 ? '' : ''} ₹ ${netAmount.abs().toInt()}',
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.red),
//                                         )
//                                       : Text(
//                                           '₹ ${netAmount.toInt()}',
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.green),
//                                         ),
//                             ],
//                           );
//                         } else {
//                           return const Text('Net Amount: N/A');
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               height: h * 0.09,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 3,
//                     offset: const Offset(0, 1), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(
//                     Icons.picture_as_pdf_outlined,
//                     color: Colors.indigo.shade400,
//                   ),
//                   Icon(
//                     Icons.currency_rupee,
//                     color: Colors.indigo.shade400,
//                   ),
//                   // Icon(Icons.call,color: Colors.indigo,),
//                   IconButton(
//                     icon: FaIcon(
//                       FontAwesomeIcons.whatsapp,
//                       color: Colors.indigo.shade400,
//                     ),
//                     onPressed: () {
//                       String url =
//                           "https://wa.me/${widget.number}/?text=Dear Sir/Madam,Your Payment of 100 is pending at My Businuss(${widget.number})";
//                       launch(url);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.chat_outlined,
//                         color: Colors.indigo.shade400),
//                     onPressed: () {
//                       String phoneNumber = widget.number;
//                       String message =
//                           "Dear Sir/Madam,Your Payment of 100 is pending at My Business(${widget.number})";
//                       String url = "sms:$phoneNumber?body=$message";
//                       launch(url);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.fromLTRB(20, 10, 15, 3),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // SizedBox(width: 1,),
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       "ENTRIES",
//                       style: TextStyle(fontSize: 10, color: Colors.grey),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 25),
//                     child: Expanded(
//                       flex: 1,
//                       child: Text(
//                         "YOU GAVE",
//                         style: TextStyle(fontSize: 10, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.0, right: 8),
//                     child: Expanded(
//                       flex: 1,
//                       child: Text(
//                         "YOU GOT",
//                         style: TextStyle(fontSize: 10, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('Customers')
//                   .doc(widget.customerId)
//                   .collection('youGave')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
//                 }
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 // Extract documents from snapshot
//                 var transactionsYouGave = snapshot.data!.docs;

//                 return StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('Customers')
//                       .doc(widget.customerId)
//                       .collection('youGot')
//                       .orderBy('timestamp', descending: true)
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
//                     }
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }
//                     // Extract documents from snapshot
//                     var transactionsYouGot = snapshot.data!.docs;
//                     double totalAmountGiven = 0;
//                     for (var transaction in transactionsYouGave) {
//                       var data = transaction.data() as Map<String, dynamic>?;
//                       var amount = double.parse(data?['amount']);
//                       totalAmountGiven += amount;
//                     }

// // Calculate total amount received
//                     double totalAmountReceived = 0;
//                     for (var transaction in transactionsYouGot) {
//                       var data = transaction.data() as Map<String, dynamic>?;
//                       var amount = double.parse(data?['amount']);
//                       totalAmountReceived += amount;
//                     }
//                     print(
//                         'Total Amount Received: $totalAmountReceived'); // Print total amount received to console
//                     print(
//                         'Total Amount Given: $totalAmountGiven'); // Print total amount received to console

//                     // Calculate net amount
//                     netAmount = totalAmountGiven - totalAmountReceived;
//                     FirebaseFirestore.instance
//                         .collection('Customers')
//                         .doc(widget.customerId)
//                         .update({'netAmount': netAmount}).then((_) {
//                       print('Net Amount updated successfully!');
//                     }).catchError((error) {
//                       print('Failed to update net amount: $error');
//                     });
//                     print("${netAmount}===========");

//                     return ListView.builder(
//                       controller: ScrollController(),
//                       shrinkWrap: true,
//                       itemCount: transactionsYouGave.length +
//                           transactionsYouGot.length,
//                       itemBuilder: (context, index) {
//                         if (index < transactionsYouGave.length &&
//                             index < transactionsYouGot.length) {
//                           var transaction1 = transactionsYouGave[index].data()
//                               as Map<String, dynamic>?;
//                           var transaction2 = transactionsYouGot[index].data()
//                               as Map<String, dynamic>?;
//                           var docId1 = transactionsYouGave[index].id;
//                           var docId2 = transactionsYouGot[index].id;
//                           print("${docId1}__________________");
//                           print("${docId2}__________________");

//                           String formattedTimestamp1 =
//                               DateFormat('dd MMM yy • hh:mm a')
//                                   .format(transaction1?['timestamp'].toDate());
//                           String formattedTimestamp2 =
//                               DateFormat('dd MMM yy • hh:mm a')
//                                   .format(transaction2?['timestamp'].toDate());
//                           return Column(
//                             children: [
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                       // Container styling for youGave items
//                                       child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           EntryDetails(
//                                                             type: '0',
//                                                             Customerid: widget
//                                                                 .customerId,
//                                                             docId: docId1,
//                                                             docId2: docId2,
//                                                             Amount:
//                                                                 '${transaction1['amount']}',
//                                                             name: widget.name,
//                                                             color: myColor,
//                                                             date:
//                                                                 formattedTimestamp1,
//                                                             number:
//                                                                 widget.number,
//                                                           )));
//                                             },
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.2),
//                                                     spreadRadius: 4,
//                                                     blurRadius: 3,
//                                                     offset: const Offset(0,
//                                                         1), // changes position of shadow
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.white,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           const SizedBox(
//                                                             height: 12,
//                                                           ),
//                                                           Text(
//                                                             formattedTimestamp1,
//                                                             style:
//                                                                 const TextStyle(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     fontSize:
//                                                                         11),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         2.0),
//                                                             child: Text(
//                                                               "${transaction1!['balance'] ?? ""}",
//                                                               style: const TextStyle(
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontSize: 12),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.transparent,
//                                                       child: Center(
//                                                         child: Text(
//                                                           "₹ ${transaction1['amount']}",
//                                                           style: const TextStyle(
//                                                               color: Colors.red,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.white,
//                                                       // Add your content for the third part here
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )))),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                       // Container styling for youGave items
//                                       child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           EntryDetails(type: '',
//                                                               docId: docId1,
//                                                               docId2: docId2,
//                                                               Customerid: widget
//                                                                   .customerId,
//                                                               date:
//                                                                   formattedTimestamp1,
//                                                               Amount:
//                                                                   '${transaction2['amount']}',
//                                                               number:
//                                                                   widget.number,
//                                                               name: widget.name,
//                                                               color:
//                                                                   myColor1)));
//                                             },
//                                             child: Container(
//                                               width: double.infinity,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.2),
//                                                     spreadRadius: 4,
//                                                     blurRadius: 3,
//                                                     offset: const Offset(0,
//                                                         1), // changes position of shadow
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.white,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           const SizedBox(
//                                                             height: 12,
//                                                           ),
//                                                           Text(
//                                                             formattedTimestamp2,
//                                                             style:
//                                                                 const TextStyle(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     fontSize:
//                                                                         11),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           Container(
//                                                             // color: Colors
//                                                             //     .red.shade100,
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           2.0),
//                                                               child: Text(
//                                                                 "${transaction2!['balance'] ?? ""}",
//                                                                 style: const TextStyle(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     fontSize:
//                                                                         12),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.transparent,
//                                                       child: const Center(
//                                                         child: Text(
//                                                           "",
//                                                           style: TextStyle(
//                                                               color: Colors.red,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       height: 60,
//                                                       color: Colors.white,
//                                                       child: Center(
//                                                           child: Text(
//                                                         "₹ ${transaction2['amount']}",
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.green),
//                                                       )),
//                                                       // Add your content for the third part here
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )))),
//                             ],
//                           );
//                         } else if (index < transactionsYouGave.length) {
//                           // Render items only from youGave collection
//                           var transaction1 = transactionsYouGave[index].data()
//                               as Map<String, dynamic>?;
//                           var docId1 = transactionsYouGave[index].id;
//                           String formattedTimestamp1 =
//                               DateFormat('dd MMM yy * hh:mm a')
//                                   .format(transaction1?['timestamp'].toDate());
//                           // Your code to render items from youGave collection goes
//                           print("${docId1}--------1");

//                           return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => EntryDetails(type: '',
//                                                   docId: docId1,
//                                                   docId2: '',
//                                                   date: formattedTimestamp1,
//                                                   Customerid: widget.customerId,
//                                                   number: widget.number,
//                                                   Amount:
//                                                       '${transaction1['amount']}',
//                                                   name: widget.name,
//                                                   color: myColor1)));
//                                     },
//                                     child: Container(
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 4,
//                                             blurRadius: 3,
//                                             offset: const Offset(0,
//                                                 1), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             flex: 2,
//                                             child: Container(
//                                               height: 60,
//                                               color: Colors.white,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   const SizedBox(
//                                                     height: 12,
//                                                   ),
//                                                   Text(
//                                                     formattedTimestamp1,
//                                                     style: const TextStyle(
//                                                         color: Colors.grey,
//                                                         fontSize: 11),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 5,
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 2.0),
//                                                     child: Text(
//                                                       " ${transaction1!['balance'] ?? ""}",
//                                                       style: const TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 12),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Container(
//                                               height: 60,
//                                               color: Colors.transparent,
//                                               child: Center(
//                                                 child: Text(
//                                                   "₹ ${transaction1['amount']}",
//                                                   style: const TextStyle(
//                                                       color: Colors.red,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: Container(
//                                               height: 60,
//                                               color: Colors.white,
//                                               // Add your content for the third part here
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )));
//                         } else if (index < transactionsYouGot.length) {
//                           // Render items only from youGot collection
//                           var transaction2 = transactionsYouGot[index].data()
//                               as Map<String, dynamic>?;
//                           var docId2 = transactionsYouGot[index].id;
//                           String formattedTimestamp2 =
//                               DateFormat('dd MMM yy * hh:mm a')
//                                   .format(transaction2?['timestamp'].toDate());
//                           print("${docId2}---------2");
//                           // Your code to render items from youGot collection goes here
//                           return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                   // Container styling for youGave items
//                                   child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       EntryDetails(type: '',
//                                                         docId2: '',
//                                                         docId: docId2,
//                                                         date:
//                                                             formattedTimestamp2,
//                                                         number: widget.number,
//                                                         Amount:
//                                                             '${transaction2['amount']}',
//                                                         name: widget.name,
//                                                         color: myColor,
//                                                         Customerid:
//                                                             widget.customerId,
//                                                       )));
//                                         },
//                                         child: Container(
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey
//                                                     .withOpacity(0.2),
//                                                 spreadRadius: 4,
//                                                 blurRadius: 3,
//                                                 offset: const Offset(0,
//                                                     1), // changes position of shadow
//                                               ),
//                                             ],
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 2,
//                                                 child: Container(
//                                                   height: 60,
//                                                   color: Colors.white,
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       const SizedBox(
//                                                         height: 12,
//                                                       ),
//                                                       Text(
//                                                         formattedTimestamp2,
//                                                         style: const TextStyle(
//                                                             color: Colors.grey,
//                                                             fontSize: 11),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       Container(
//                                                         // color:
//                                                         //     Colors.red.shade100,
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       2.0),
//                                                           child: Text(
//                                                             "${transaction2!['balance'] ?? ""}",
//                                                             style:
//                                                                 const TextStyle(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     fontSize:
//                                                                         12),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 1,
//                                                 child: Container(
//                                                   height: 60,
//                                                   color: Colors.transparent,
//                                                   child: const Center(
//                                                     child: Text(
//                                                       "",
//                                                       style: TextStyle(
//                                                           color: Colors.red,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 1,
//                                                 child: Container(
//                                                   height: 60,
//                                                   color: Colors.white,
//                                                   child: Center(
//                                                       child: Text(
//                                                     "₹ ${transaction2['amount']}",
//                                                     style: const TextStyle(
//                                                         color: Colors.green),
//                                                   )),
//                                                   // Add your content for the third part here
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ))));
//                         }
//                       },
//                     );
//                   },
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
