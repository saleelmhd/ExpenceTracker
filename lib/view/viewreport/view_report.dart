import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ViewReport extends StatefulWidget {
  ViewReport({super.key, required this.userId});
  String userId;
  @override
  State<ViewReport> createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  int totalYouGaveLength = 0;
  int totalYouGotLength = 0;
  final List<Color> tabColors = [
    Colors.red,
    Colors.green
  ]; // Define colors for each tab
  int _selectedIndex = 0; // Variable to track the selected tab index
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Text(
            "View Report",
            style: TextStyle(fontSize: 17),
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   elevation: 2,
        //   color: Colors.white,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8)),
        //         backgroundColor: Colors.indigo,
        //         foregroundColor: Colors.white),
        //     onPressed: () {},
        //     child: const Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(Icons.picture_as_pdf_outlined),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text("DOWNLOAD"),
        //       ],
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 55,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                _selectStartDate(context);
                              },
                              child: const Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                  Text("  START DATE",
                                      style: TextStyle(
                                          color: Colors.indigo, fontSize: 13)),
                                ],
                              )),
                            )),
                            Container(
                              width: 1,
                              color: Colors.black12,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                _selectEndDate(context);
                              },
                              child: const Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                  Text("  END DATE",
                                      style: TextStyle(
                                          color: Colors.indigo, fontSize: 13)),
                                ],
                              )),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        // height: 50,
                        color: Colors.white,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.indigo,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                              hintText: "Search Entries"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Net Balance",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),

                    // Text(
                    //   "₹ 75",
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       color: Colors.green,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('users')
                    //       .doc(widget.userId)
                    //       .collection('totalGaveAmount')
                    //       .snapshots(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<QuerySnapshot> gaveSnapshot) {
                    //     if (gaveSnapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const Text("");
                    //     }
                    //     if (gaveSnapshot.hasError) {
                    //       return Text('Error: ${gaveSnapshot.error}');
                    //     }
                    //     if (!gaveSnapshot.hasData ||
                    //         gaveSnapshot.data!.docs.isEmpty) {
                    //       return const Text('');
                    //     }

                    //     // Calculate total gave amount
                    //     var totalGaveAmount =
                    //         gaveSnapshot.data!.docs.fold(0, (sum, doc) {
                    //       var data = doc.data() as Map<String, dynamic>?;
                    //       if (data != null && data['totalGaveAmount'] is num) {
                    //         return sum +
                    //             (data['totalGaveAmount'] as num).toInt();
                    //       }
                    //       return sum;
                    //     });

                    //     // Now, do the same for 'totalGotAmount' collection
                    //     return StreamBuilder<QuerySnapshot>(
                    //       stream: FirebaseFirestore.instance
                    //           .collection('users')
                    //           .doc(widget.userId)
                    //           .collection('totalGotAmount')
                    //           .snapshots(),
                    //       builder: (BuildContext context,
                    //           AsyncSnapshot<QuerySnapshot> gotSnapshot) {
                    //         if (gotSnapshot.connectionState ==
                    //             ConnectionState.waiting) {
                    //           return const Text("");
                    //         }
                    //         if (gotSnapshot.hasError) {
                    //           return Text('Error: ${gotSnapshot.error}');
                    //         }
                    //         if (!gotSnapshot.hasData ||
                    //             gotSnapshot.data!.docs.isEmpty) {
                    //           return const Text('');
                    //         }

                    //         // Calculate total got amount
                    //         var totalGotAmount =
                    //             gotSnapshot.data!.docs.fold(0, (sum, doc) {
                    //           var data = doc.data() as Map<String, dynamic>?;
                    //           if (data != null &&
                    //               data['totalGotAmount'] is num) {
                    //             return sum +
                    //                 (data['totalGotAmount'] as num).toInt();
                    //           }
                    //           return sum;
                    //         });

                    //         // Calculate total sum
                    //         var totalSum = totalGaveAmount - totalGotAmount;

                    //         // Display the totals
                    //         return Column(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           children: [
                    //             Text(
                    //               '   ${totalSum.abs()}',
                    //               style: const TextStyle(
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.green,
                    //               ),
                    //             ),
                    //             // Text(
                    //             //   'Total Gave Amount: $totalGaveAmount',
                    //             //   style: const TextStyle(
                    //             //     fontSize: 12,
                    //             //     fontWeight: FontWeight.bold,
                    //             //     color: Colors.red,
                    //             //   ),
                    //             // ),
                    //             // Text(
                    //             //   'Total Got Amount: $totalGotAmount',
                    //             //   style: const TextStyle(
                    //             //     fontSize: 12,
                    //             //     fontWeight: FontWeight.bold,
                    //             //     color: Colors.blue,
                    //             //   ),
                    //             // ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    // StreamBuilder<DocumentSnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('users')
                    //       .doc(widget.userId)
                    //       .snapshots(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<DocumentSnapshot> gaveSnapshot) {
                    //     if (gaveSnapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return const CircularProgressIndicator();
                    //     }
                    //     if (gaveSnapshot.hasError) {
                    //       return Text('Error: ${gaveSnapshot.error}');
                    //     }
                    //     if (!gaveSnapshot.hasData ||
                    //         gaveSnapshot.data!.data() == null) {
                    //       return const Text('');
                    //     }

                    //     // Access the data from the DocumentSnapshot
                    //     var userData =
                    //         gaveSnapshot.data!.data() as Map<String, dynamic>;

                    //     // Calculate total gave amount
                    //     var totalGaveAmount = 0;
                    //     var totalGotAmount = 0;
                    //     if (userData.containsKey('totalGaveAmount') &&
                    //         userData['totalGaveAmount'] is num) {
                    //       totalGaveAmount =
                    //           (userData['totalGaveAmount'] as num).toInt();
                    //     }
                    //     if (userData.containsKey('totalGotAmount') &&
                    //         userData['totalGotAmount'] is num) {
                    //       totalGotAmount =
                    //           (userData['totalGotAmount'] as num).toInt();
                    //     }

                    //     // Display total gave amount
                    //     return Text(
                    //       '  ${(totalGaveAmount - totalGotAmount).abs()}',
                    //       style: const TextStyle(
                    //           fontSize: 18, fontWeight: FontWeight.bold),
                    //     );
                    //   },
                    // ),
                    FutureBuilder(
                      future: Future.wait(
                          [getTotalGaveAmount(), getTotalGotAmount()]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          double totalGaveAmt = snapshot.data?[0] ?? 0;
                          double totalGotAmt = snapshot.data?[1] ?? 0;
                          double difference = totalGaveAmt - totalGotAmt;
                          return Text(
                            '  ${difference.toInt().abs()}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 40,
                      width: 140,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("TOTAL", style: TextStyle(fontSize: 10)),
                          Text(" Entries",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      // height: 40,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("YOU GAVE",
                                style: TextStyle(fontSize: 10)),
                            // StreamBuilder<DocumentSnapshot>(
                            //   stream: FirebaseFirestore.instance
                            //       .collection('users')
                            //       .doc(widget.userId)
                            //       .snapshots(),
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const CircularProgressIndicator();
                            //     }
                            //     if (snapshot.hasError) {
                            //       return Text('Error: ${snapshot.error}');
                            //     }
                            //     if (!snapshot.hasData ||
                            //         !snapshot.data!.exists) {
                            //       return const Text('');
                            //     }

                            //     // Extract total got amount from document snapshot
                            //     var data = snapshot.data!.data() as Map<String,
                            //         dynamic>?; // Ensure data is cast to the correct type
                            //     if (data != null) {
                            //       var totalGaveAmount = data['totalGaveAmount']
                            //           as num?; // Access the value using the [] operator

                            //       if (totalGaveAmount != null) {
                            //         return Text(
                            //           '${totalGaveAmount.toInt()}',
                            //           style: const TextStyle(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.red),
                            //         );
                            //       }
                            //     }

                            //     return const Text('');
                            //   },
                            // ),

                            FutureBuilder<double>(
                              future: getTotalGaveAmount(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      height: 10,
                                      width: 10,
                                      child: const CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  double totalGaveAmt = snapshot.data ?? 0;
                                  return Text(
                                    '${totalGaveAmt.toInt().abs()}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        // height: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("YOU GOT",
                                style: TextStyle(fontSize: 10)),
                            // Text("₹ 88",
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.green)),
                            // StreamBuilder<DocumentSnapshot>(
                            //   stream: FirebaseFirestore.instance
                            //       .collection('users')
                            //       .doc(widget.userId)
                            //       .snapshots(),
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const Center(
                            //           child: CircularProgressIndicator());
                            //     }
                            //     if (snapshot.hasError) {
                            //       return Text('Error: ${snapshot.error}');
                            //     }
                            //     if (!snapshot.hasData ||
                            //         !snapshot.data!.exists) {
                            //       return const Text('');
                            //     }

                            //     // Extract total got amount from document snapshot
                            //     var data = snapshot.data!.data() as Map<String,
                            //         dynamic>?; // Ensure data is cast to the correct type

                            //     if (data != null) {
                            //       var totalGotAmount = data['totalGotAmount']
                            //           as num?; // Access the value using the [] operator
                            //       if (totalGotAmount != null) {
                            //         return Text(
                            //           '${totalGotAmount.toInt()}',
                            //           style: const TextStyle(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.green),
                            //         );
                            //       }
                            //     }

                            //     return const Text('');
                            //   },
                            // ),
                            FutureBuilder<double>(
                              future: getTotalGotAmount(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      height: 10,
                                      width: 10,
                                      child: const CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  double totalGotAmt = snapshot.data ?? 0;
                                  return Text(
                                    '${totalGotAmt.toInt().abs()}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
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
                      text: 'YOU GAVE',
                    ),
                    Tab(text: 'YOU GOT'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users') // Reference the main collection
                        .doc(
                            widget.userId) // Reference a specific user document
                        .collection(
                            'Customers') // Reference the "Customers" subcollection
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                                height: 50,
                                child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/8480/8480293.png')),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('No Transaction found.'),
                          ],
                        );
                      }

                      // Extract customer documents from snapshot
                      var customerDocs = snapshot.data!.docs;
                      double totalGaveAmt = 0;

                      // Returning ListView.builder to display transactions for all customers
                      return ListView.builder(
                        itemCount: customerDocs.length,
                        itemBuilder: (context, index) {
                          var customerId = customerDocs[index].id;

                          return Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userId)
                                    .collection('Customers')
                                    .doc(customerId)
                                    .collection('youGave')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        youGaveSnapshot) {
                                  if (youGaveSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (youGaveSnapshot.hasError) {
                                    return Text(
                                        'Error: ${youGaveSnapshot.error}');
                                  }
                                  if (!youGaveSnapshot.hasData ||
                                      youGaveSnapshot.data!.docs.isEmpty) {
                                    return const SizedBox(); // Return an empty SizedBox if no data is found for this customer
                                  }

                                  // Extract "youGave" documents for this customer from snapshot
                                  var youGaveDocs = youGaveSnapshot.data!.docs;
                                  var totalGaveAmountRef = FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(widget.userId);

                                  // Use a transaction or set operation to insert/update the total gave amount
                                  FirebaseFirestore.instance
                                      .runTransaction((transaction) async {
                                    // Get the existing document snapshot
                                    var docSnapshot = await transaction
                                        .get(totalGaveAmountRef);

                                    // Calculate the total gave amount
                                    double totalGaveAmount = 0;
                                    youGaveDocs.forEach((transactionDoc) {
                                      var transaction = transactionDoc.data()
                                          as Map<String, dynamic>;
                                      totalGaveAmount +=
                                          transaction['amount'] ?? 0;
                                    });

                                    // Update the document with the new total gave amount
                                    if (docSnapshot.exists) {
                                      // If the document already exists, update it
                                      transaction.update(totalGaveAmountRef,
                                          {'totalGaveAmount': totalGaveAmount});
                                    } else {
                                      // If the document doesn't exist, create it
                                      transaction.set(totalGaveAmountRef,
                                          {'totalGaveAmount': totalGaveAmount});
                                    }
                                  }).then((_) {
                                    print(
                                        'Total gave amount inserted/updated successfully.');
                                  }).catchError((error) {
                                    print(
                                        'Error inserting/updating total gave amount: $error');
                                  });
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        controller: ScrollController(),
                                        shrinkWrap: true,
                                        itemCount: youGaveDocs.length,
                                        itemBuilder: (context, index) {
                                          var transaction = youGaveDocs[index]
                                              .data() as Map<String, dynamic>;
                                          var docId = youGaveDocs[index].id;

                                          String formattedTimestamp =
                                              DateFormat('dd MMM yy • hh:mm a')
                                                  .format(
                                                      transaction['timestamp']
                                                          .toDate());
                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Handle onTap action
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 4,
                                                              blurRadius: 3,
                                                              offset: const Offset(
                                                                  0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                height: 60,
                                                                color: Colors
                                                                    .white,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    Text(
                                                                      formattedTimestamp,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              11),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              2.0),
                                                                      child:
                                                                          Text(
                                                                        "${transaction['balance'] ?? ""}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                height: 60,
                                                                color: Colors
                                                                    .transparent,
                                                                child: Center(
                                                                  child: Text(
                                                                    "₹ ${transaction['amount'].toInt()}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userId)
                                    .collection('Customers')
                                    .doc(customerId)
                                    .collection('youGot')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot>
                                        youGotSnapshot) {
                                  if (youGotSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (youGotSnapshot.hasError) {
                                    return Text(
                                        'Error: ${youGotSnapshot.error}');
                                  }
                                  if (!youGotSnapshot.hasData ||
                                      youGotSnapshot.data!.docs.isEmpty) {
                                    return const SizedBox(); // Return an empty SizedBox if no data is found for this customer
                                  }

                                  // Extract "youGave" documents for this customer from snapshot
                                  var youGotDocs = youGotSnapshot.data!.docs;
                                  var totalGotAmountReff = FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(widget.userId);

                                  FirebaseFirestore.instance
                                      .runTransaction((transaction) async {
                                    // Get the existing document snapshot
                                    var docSnapshot = await transaction
                                        .get(totalGotAmountReff);

                                    // Calculate the total gave amount
                                    double totalGotAmount = 0;
                                    youGotDocs.forEach((transactionDoc) {
                                      var transaction = transactionDoc.data()
                                          as Map<String, dynamic>;
                                      totalGotAmount +=
                                          transaction['amount'] ?? 0;
                                    });

                                    // Update the document with the new total gave amount
                                    if (docSnapshot.exists) {
                                      // If the document already exists, update it
                                      transaction.update(totalGotAmountReff,
                                          {'totalGotAmount': totalGotAmount});
                                    } else {
                                      // If the document doesn't exist, create it
                                      transaction.set(totalGotAmountReff,
                                          {'totalGotAmount': totalGotAmount});
                                    }
                                  }).then((_) {
                                    print(
                                        'Total got amount inserted/updated successfully.');
                                  }).catchError((error) {
                                    print(
                                        'Error inserting/updating total got amount: $error');
                                  });
                                  return const SizedBox();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users') // Reference the main collection
                        .doc(
                            widget.userId) // Reference a specific user document
                        .collection(
                            'Customers') // Reference the "Customers" subcollection
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                                height: 50,
                                child: Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/8480/8480293.png')),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('No Transaction found.'),
                          ],
                        );
                      }

                      // Extract customer documents from snapshot
                      var customerDocs = snapshot.data!.docs;

                      // Returning ListView.builder to display transactions for all customers
                      return ListView.builder(
                        itemCount: customerDocs.length,
                        itemBuilder: (context, index) {
                          var customerId = customerDocs[index].id;

                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .collection('Customers')
                                .doc(customerId)
                                .collection('youGot')
                                .orderBy('timestamp', descending: true)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> youGotSnapshot) {
                              if (youGotSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (youGotSnapshot.hasError) {
                                return Text('Error: ${youGotSnapshot.error}');
                              }
                              if (!youGotSnapshot.hasData ||
                                  youGotSnapshot.data!.docs.isEmpty) {
                                return const SizedBox(); // Return an empty SizedBox if no data is found for this customer
                              }

                              // Extract "youGave" documents for this customer from snapshot
                              var youGotDocs = youGotSnapshot.data!.docs;
                              var totalGotAmountReff = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(widget.userId);

                              FirebaseFirestore.instance
                                  .runTransaction((transaction) async {
                                // Get the existing document snapshot
                                var docSnapshot =
                                    await transaction.get(totalGotAmountReff);

                                // Calculate the total gave amount
                                double totalGotAmount = 0;
                                youGotDocs.forEach((transactionDoc) {
                                  var transaction = transactionDoc.data()
                                      as Map<String, dynamic>;
                                  totalGotAmount += transaction['amount'] ?? 0;
                                });

                                // Update the document with the new total gave amount
                                if (docSnapshot.exists) {
                                  // If the document already exists, update it
                                  transaction.update(totalGotAmountReff,
                                      {'totalGotAmount': totalGotAmount});
                                } else {
                                  // If the document doesn't exist, create it
                                  transaction.set(totalGotAmountReff,
                                      {'totalGotAmount': totalGotAmount});
                                }
                              }).then((_) {
                                print(
                                    'Total got amount inserted/updated successfully.');
                              }).catchError((error) {
                                print(
                                    'Error inserting/updating total got amount: $error');
                              });
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    controller: ScrollController(),
                                    shrinkWrap: true,
                                    itemCount: youGotDocs.length,
                                    itemBuilder: (context, index) {
                                      var transaction = youGotDocs[index].data()
                                          as Map<String, dynamic>;
                                      var docId = youGotDocs[index].id;

                                      String formattedTimestamp =
                                          DateFormat('dd MMM yy • hh:mm a')
                                              .format(transaction['timestamp']
                                                  .toDate());
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Handle onTap action
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 4,
                                                          blurRadius: 3,
                                                          offset: const Offset(
                                                              0,
                                                              1), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            height: 60,
                                                            color: Colors.white,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const SizedBox(
                                                                    height: 12),
                                                                Text(
                                                                  formattedTimestamp,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                                  child: Text(
                                                                    "${transaction['balance'] ?? ""}",
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
                                                            height: 60,
                                                            color: Colors
                                                                .transparent,
                                                            child: Center(
                                                              child: Text(
                                                                "₹ ${transaction['amount'].toInt()}",
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
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }

  DateTime? _selectedstartDate;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedstartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedstartDate) {
      setState(() {
        _selectedstartDate = picked;
      });
    }
  }

  DateTime? _selectedEndDate;
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  Future<double> getTotalGaveAmount() async {
    double totalGaveAmt = 0;
    var customersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('Customers')
        .get();

    for (var customerDoc in customersSnapshot.docs) {
      var customerId = customerDoc.id;
      var youGaveDocsSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('Customers')
          .doc(customerId)
          .collection('youGave')
          .get();

      for (var youGaveDoc in youGaveDocsSnap.docs) {
        var transaction = youGaveDoc.data() as Map<String, dynamic>;
        totalGaveAmt += (transaction['amount'] ?? 0);
      }
    }

    return totalGaveAmt;
  }

  Future<double> getTotalGotAmount() async {
    double totalGotAmt = 0;
    var customersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('Customers')
        .get();

    for (var customerDoc in customersSnapshot.docs) {
      var customerId = customerDoc.id;
      var youGotDocsSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('Customers')
          .doc(customerId)
          .collection('youGot')
          .get();

      for (var youGotDoc in youGotDocsSnap.docs) {
        var transaction = youGotDoc.data() as Map<String, dynamic>;
        totalGotAmt += (transaction['amount'] ?? 0);
      }
    }

    return totalGotAmt;
  }
}
