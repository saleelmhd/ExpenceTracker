import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/globel_variable.dart';
import '../viewreport/entry_details.dart';
import 'gave&got_transaction.dart';

class Transactions extends StatefulWidget {
  String name;
  String number;
  String customerId;
  String userId;
  Transactions({
    super.key,
    required this.name,
    required this.number,
    required this.userId,
    required this.customerId,
  });

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Color> tabColors = [
    Colors.red,
    Colors.green
  ]; // Define colors for each tab
  int _selectedIndex = 0; // Variable to track the selected tab index

  int? netAmount = 0;
  bool isGaveSelected = false;
  Color myColor = Colors.red;
  Color myColor1 = Colors.green;
  late List<Map<String, dynamic>>
      transactions; // List to store transaction data

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionPay(
                              docid: widget.customerId,
                              isGaveSelected: isGaveSelected = true,
                              name: widget.name,
                              userId: widget.userId,
                            )),
                  );
                },
                child: const Text("YOU GAVE ₹"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionPay(
                              isGaveSelected: isGaveSelected = false,
                              name: widget.name,
                              docid: widget.customerId,
                              userId: widget.userId,
                            )),
                  );
                },
                child: const Text("YOU GOT ₹"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor:
                          Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                              .withOpacity(1.0),
                      child: Text(
                        widget.name.substring(0, 1),
                        style: const TextStyle(color: Colors.white),
                      )),
                  Text(
                    "  ${widget.name}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    _makePhoneCall(widget.number);
                  },
                  child: Icon(Icons.call))
            ],
          ),
          actions: const [
            // Icon(
            //   Icons.more_vert,
            // ),
          ],
        ),
        body: Column(children: [
          Container(
            color: Colors.indigo,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users') // Reference the main collection
                        .doc(
                            widget.userId) // Reference a specific user document
                        .collection('Customers')
                        .doc(widget.customerId)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Get the customer document data
                      var customerData =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      print('${netAmount}*********');
                      // Check if the document exists and contains the netAmount
                      if (customerData != null &&
                          customerData.containsKey('netAmount')) {
                        int netAmount = customerData['netAmount'];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                netAmount == 0
                                    ? const Text("Settled up")
                                    : netAmount < 0
                                        ? const Text(
                                            "You will give",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            "You will get",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                Icon(
                                  netAmount < 0
                                      ? Icons.emoji_emotions
                                      : Icons.emoji_emotions_outlined,
                                  color:
                                      netAmount < 0 ? Colors.green : Colors.red,
                                ),
                              ],
                            ),
                            netAmount == 0.0
                                ? const Text("0")
                                : netAmount < 0
                                    ? Text(
                                        '${netAmount < 0 ? '' : ''} ₹ ${netAmount.abs()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      )
                                    : Text(
                                        '₹ ${netAmount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                          ],
                        );
                      } else {
                        return const Text('Net Amount: N/A');
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: h * 0.09,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.indigo.shade400,
                ),
                Icon(
                  Icons.currency_rupee,
                  color: Colors.indigo.shade400,
                ),
                // Icon(Icons.call,color: Colors.indigo,),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.indigo.shade400,
                  ),
                  onPressed: () {
                    String url =
                        "https://wa.me/${widget.number}/?text=Dear Sir/Madam,Your Payment of ${netAmount?.abs() ?? 0} is pending at My Businuss(${widget.number})";
                    launch(url);
                  },
                ),
                IconButton(
                  icon:
                      Icon(Icons.chat_outlined, color: Colors.indigo.shade400),
                  onPressed: () {
                    String phoneNumber = widget.number;
                    String message =
                        "Dear Sir/Madam,Your Payment of ${netAmount?.abs() ?? 0}' is pending at My Business(${widget.number})";
                    String url = "sms:$phoneNumber?body=$message";
                    launch(url);
                  },
                ),
              ],
            ),
          ),
          Container(
            // Container for the TabBar
            decoration: BoxDecoration(
              color: tabColors[_selectedIndex], // TabBar background color
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            margin: const EdgeInsets.all(10.0), // Margin for the container
            child: TabBar(
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              labelStyle: const TextStyle(
                  color: Colors
                      .white), // Set label color based on selected tab index
              onTap: (index) {
                setState(() {
                  _selectedIndex = index; // Update selected tab index
                });
              },
              tabs: const [
                Tab(
                  text: 'You Gave',
                ),
                Tab(text: 'You Got'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users') // Reference the main collection
                      .doc(widget.userId) // Reference a specific user document
                      .collection(
                          'Customers') // Reference the subcollection "Customers"
                      .doc(widget
                          .customerId) // Reference a specific customer document
                      .collection(
                          'youGave') // Reference the subcollection "youGave"
                      .orderBy('timestamp',
                          descending: true) // Order the documents by timestamp
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                              const CircularProgressIndicator()); // Show loading indicator while data is being fetched
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Extract documents from snapshot
                    var transactionsYouGave = snapshot.data!.docs;

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users') // Reference the main collection
                          .doc(widget
                              .userId) // Reference a specific user document
                          .collection('Customers')
                          .doc(widget.customerId)
                          .collection('youGot')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        // Extract documents from snapshot

                        var transactionsYouGot = snapshot.data!.docs;
                        double totalAmountGiven = 0;
                        for (var transaction in transactionsYouGave) {
                          var data =
                              transaction.data() as Map<String, dynamic>?;
                          print("${data?['amount'].runtimeType}");
                          var amount = data?['amount'];

                          totalAmountGiven += amount;
                        }

// Calculate total amount received
                        double totalAmountReceived = 0;
                        for (var transaction in transactionsYouGot) {
                          var data =
                              transaction.data() as Map<String, dynamic>?;
                          var amount = data?['amount'];
                          totalAmountReceived += amount;
                        }
                        print(
                            'Total Amount Received: $totalAmountReceived'); // Print total amount received to console
                        print(
                            'Total Amount Given: $totalAmountGiven'); // Print total amount received to console

                        // Calculate net amount
                        netAmount = totalAmountGiven.toInt() -
                            totalAmountReceived.toInt();
                        FirebaseFirestore.instance
                            .collection(
                                'users') // Reference the main collection
                            .doc(widget
                                .userId) // Reference a specific user document
                            .collection('Customers')
                            .doc(widget.customerId)
                            .update({'netAmount': netAmount}).then((_) {
                          print('Net Amount updated successfully!');
                        }).catchError((error) {
                          print('Failed to update net amount: $error');
                        });
                        print("${netAmount}===========");

                        return ListView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: transactionsYouGave.length,
                          itemBuilder: (context, index) {
                            var transaction1 = transactionsYouGave[index].data()
                                as Map<String, dynamic>?;
                            // var transaction2 = transactionsYouGot[index].data()
                            //     as Map<String, dynamic>?;
                            var docId1 = transactionsYouGave[index].id;
                            // var docId2 = transactionsYouGot[index].id;
                            print("${docId1}__________________");

                            String formattedTimestamp1 =
                                DateFormat('dd MMM yy • hh:mm a').format(
                                    transaction1?['timestamp'].toDate());
                            // String formattedTimestamp2 =
                            //     DateFormat('dd MMM yy • hh:mm a').format(
                            //         transaction2?['timestamp'].toDate());
                            return Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        // Container styling for youGave items
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EntryDetails(
                                                              details:
                                                                  '${transaction1['details'] ?? ''}',
                                                              userId:
                                                                  widget.userId,
                                                              Customerid: widget
                                                                  .customerId,
                                                              docId: docId1,
                                                              Amount:
                                                                  '${transaction1['amount'].toInt()}',
                                                              name: widget.name,
                                                              color: myColor,
                                                              date: formattedTimestamp1
                                                                  .toString(),
                                                              number:
                                                                  widget.number,
                                                            )));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 4,
                                                      blurRadius: 3,
                                                      offset: const Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            transaction1![
                                                                        'details'] ==
                                                                    null
                                                                ? Column(
                                                                    children: [
                                                                      Text(
                                                                        formattedTimestamp1
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 11),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        formattedTimestamp1
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 11),
                                                                      ),
                                                                      Text(
                                                                        '${transaction1['details']}',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 11),
                                                                      )
                                                                    ],
                                                                  ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                              child: Text(
                                                                "${transaction1!['balance'] ?? ""}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Center(
                                                          child: Text(
                                                            "₹ ${transaction1['amount'].toInt()}",
                                                            style: const TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )))),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users') // Reference the main collection
                      .doc(widget.userId) // Reference a specific user document
                      .collection('Customers')
                      .doc(widget.customerId)
                      .collection('youGave')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Extract documents from snapshot
                    var transactionsYouGave = snapshot.data!.docs;

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users') // Reference the main collection
                          .doc(widget
                              .userId) // Reference a specific user document
                          .collection('Customers')
                          .doc(widget.customerId)
                          .collection('youGot')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        // Extract documents from snapshot
                        var transactionsYouGot = snapshot.data!.docs;
                        double totalAmountGiven = 0;
                        for (var transaction in transactionsYouGave) {
                          var data =
                              transaction.data() as Map<String, dynamic>?;
                          var amount = data?['amount'];
                          totalAmountGiven += amount;
                        }

// Calculate total amount received
                        double totalAmountReceived = 0;
                        for (var transaction in transactionsYouGot) {
                          var data =
                              transaction.data() as Map<String, dynamic>?;
                          var amount = data?['amount'];
                          totalAmountReceived += amount;
                        }
                        print(
                            'Total Amount Received: $totalAmountReceived'); // Print total amount received to console
                        print(
                            'Total Amount Given: $totalAmountGiven'); // Print total amount received to console

                        // Calculate net amount
                        netAmount = totalAmountGiven.toInt() -
                            totalAmountReceived.toInt();
                        FirebaseFirestore.instance
                            .collection(
                                'users') // Reference the main collection
                            .doc(widget
                                .userId) // Reference a specific user document
                            .collection('Customers')
                            .doc(widget.customerId)
                            .update({'netAmount': netAmount}).then((_) {
                          print('Net Amount updated successfully!');
                        }).catchError((error) {
                          print('Failed to update net amount: $error');
                        });
                        print("${netAmount}===========");

                        return ListView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: transactionsYouGot.length,
                          itemBuilder: (context, index) {
                            var transaction2 = transactionsYouGot[index].data()
                                as Map<String, dynamic>?;
                            // var docId1 = transactionsYouGave[index].id;
                            var docId2 = transactionsYouGot[index].id;
                            // print("${docId1}__________________");
                            print("${docId2}__________________");

                            // String formattedTimestamp1 =
                            //     DateFormat('dd MMM yy • hh:mm a').format(
                            //         transaction1?['timestamp'].toDate());
                            String formattedTimestamp2 =
                                DateFormat('dd MMM yy • hh:mm a').format(
                                    transaction2?['timestamp'].toDate());
                            return Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        // Container styling for youGave items
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EntryDetails(
                                                              details:
                                                                  '${transaction2['details'] ?? ''}',
                                                              userId:
                                                                  widget.userId,
                                                              Customerid: widget
                                                                  .customerId,
                                                              docId: docId2,
                                                              Amount:
                                                                  '${transaction2['amount'].toInt()}',
                                                              name: widget.name,
                                                              color: myColor1,
                                                              date:
                                                                  formattedTimestamp2,
                                                              number:
                                                                  widget.number,
                                                            )));
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 4,
                                                      blurRadius: 3,
                                                      offset: const Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            transaction2![
                                                                        'details'] ==
                                                                    null
                                                                ? Column(
                                                                    children: [
                                                                      Text(
                                                                        formattedTimestamp2,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 11),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        formattedTimestamp2,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 11),
                                                                      ),
                                                                      Text(
                                                                          transaction2[
                                                                              'details'],
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11))
                                                                    ],
                                                                  ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                              child: Text(
                                                                "${transaction2!['balance'] ?? ""}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Center(
                                                          child: Text(
                                                            "₹ ${transaction2['amount'].toInt()}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )))),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
