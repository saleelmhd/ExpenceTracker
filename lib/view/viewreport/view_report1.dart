import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class ViewReports extends StatefulWidget {
  ViewReports({super.key, required this.userId});
  String userId;
  @override
  State<ViewReports> createState() => _ViewReportsState();
}

class _ViewReportsState extends State<ViewReports> {
  int totalYouGaveLength = 0;
  int totalYouGotLength = 0;
  final List<Color> tabColors = [
    Colors.red,
    Colors.green
  ]; // Define colors for each tab
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          physics: const NeverScrollableScrollPhysics(),
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
                                            color: Colors.indigo,
                                            fontSize: 13)),
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
                                            color: Colors.indigo,
                                            fontSize: 13)),
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

                            // return Text(
                            //   '  ₹ ${difference.toInt().abs()}',
                            //   style: const TextStyle(
                            //       fontSize: 16, fontWeight: FontWeight.bold),
                            // );
                            return difference == 0
                                ? const Text("0")
                                : difference > 0
                                    ? Text(
                                        '  ₹ ${difference.toInt().abs()}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        '  ₹ ${difference.toInt().abs()}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
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
                                        child:
                                            const CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    double totalGaveAmt = snapshot.data ?? 0;
                                    return Text(
                                      '₹ ${totalGaveAmt.toInt().abs()}',
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
                                        child:
                                            const CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    double totalGotAmt = snapshot.data ?? 0;
                                    return Text(
                                      ' ₹ ${totalGotAmt.toInt().abs()}',
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
                      .collection('Customers')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot> customersSnapshot) {
                    if (!customersSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<DocumentSnapshot> customers =
                        customersSnapshot.data!.docs;

                    return FutureBuilder(
                      future: _getAllTransactions(customers),
                      builder: (context,
                          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<DocumentSnapshot> allTransactions = snapshot.data!;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: allTransactions.length,
                            itemBuilder: (context, index) {
                              var transaction = allTransactions[index];
                              var amount = transaction['amount'];

                              var color =
                                  transaction.reference.path.contains('youGave')
                                      ? Colors.red
                                      : Colors.green;
                              String formattedDateTime = '';
                              if (allTransactions[index] is DocumentSnapshot) {
                                DocumentSnapshot document =
                                    allTransactions[index] as DocumentSnapshot;
                                if (document['timestamp'] != null) {
                                  var timestamp = document['timestamp'];
                                  var date = timestamp.toDate();
                                  formattedDateTime =
                                      DateFormat('dd MMM yy • hh:mm a')
                                          .format(date);
                                }
                              }

                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          // Container styling for youGave items
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {},
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
                                                          height: 50,
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  allTransactions[
                                                                          index]
                                                                      [
                                                                      'custNames'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                                Text(
                                                                  formattedDateTime,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            height: 50,
                                                            color: Colors
                                                                .red.shade50,
                                                            child: transaction
                                                                    .reference
                                                                    .path
                                                                    .contains(
                                                                        'youGave')
                                                                ? Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        ' ₹ ${amount.toStringAsFixed(0)} ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                color),
                                                                      )
                                                                    ],
                                                                  )
                                                                : const Text(
                                                                    "")),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                            color: Colors.white,
                                                            height: 50,
                                                            child: transaction
                                                                    .reference
                                                                    .path
                                                                    .contains(
                                                                        'youGot')
                                                                ? Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        ' ₹ ${amount.toStringAsFixed(0)} ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                color),
                                                                      )
                                                                    ],
                                                                  )
                                                                : const Text(
                                                                    "")),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )))),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ]))),
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

  String _formatAmount(dynamic amount) {
    double parsedAmount = double.parse(amount.toString());
    String formattedAmount = parsedAmount.toString();

    // Check if amount has decimal values
    if (parsedAmount % 1 == 0) {
      // If amount is an integer, don't display decimal part
      formattedAmount = parsedAmount.toInt().toString();
    }

    return formattedAmount;
  }

  Future<List<DocumentSnapshot>> _getAllTransactions(
      List<DocumentSnapshot> customers) async {
    List<DocumentSnapshot> allTransactions = [];

    for (var customer in customers) {
      var youGotSnapshot = await customer.reference
          .collection('youGot')
          .orderBy('timestamp', descending: true)
          .get();

      var youGaveSnapshot = await customer.reference
          .collection('youGave')
          .orderBy('timestamp', descending: true)
          .get();

      allTransactions.addAll(youGotSnapshot.docs);
      allTransactions.addAll(youGaveSnapshot.docs);
    }

    allTransactions.sort((a, b) {
      if (a['timestamp'] == null || b['timestamp'] == null) {
        return a['timestamp'] == null ? 1 : -1;
      }
      return (b['timestamp'] as Timestamp)
          .compareTo(a['timestamp'] as Timestamp);
    });

    return allTransactions;
  }
}
