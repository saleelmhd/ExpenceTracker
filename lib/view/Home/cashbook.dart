import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensenote/cashbookpay.dart';
import 'package:expensenote/view/Home/CashbookReport.dart';
import 'package:expensenote/view/Home/cashbookentrydetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Cashbook extends StatefulWidget {
  String customerId;
  String userId;
  Cashbook({super.key, required this.customerId, required this.userId});

  @override
  State<Cashbook> createState() => _CashbookState();
}

class _CashbookState extends State<Cashbook> {
  var totalentries;
  final List<Color> tabColors = [
    Colors.green,
    Colors.red,
  ]; // Define colors for each tab
  int _selectedIndex = 0; // Variable to track the selected tab index

  double? netAmount = 0.0;
  bool isOutSelected = false;
  Color myColor1 = Colors.red;
  Color myColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CashbookPay(
                                isOutSelected: isOutSelected = false,
                                name: '',
                                userId: widget.userId,
                              )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.green,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("IN"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CashbookPay(
                                userId: widget.userId,
                                isOutSelected: isOutSelected = true,
                                name: '',
                              )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("OUT"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  radius: 23,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2)),
                      child: const Icon(
                        Icons.currency_rupee_outlined,
                        color: Colors.blue,
                      ))),
              const Text(
                "   Cashbook",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              // height: 170,
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Column(
                              //   children: [
                              //     Text(
                              //       "₹ 50",
                              //       style: TextStyle(color: Colors.green),
                              //     ),
                              //     Text("Today Balance"),
                              //   ],
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Text("Total Balance   :  "),
                                        // StreamBuilder<DocumentSnapshot>(
                                        //   stream: FirebaseFirestore.instance
                                        //       .collection('users')
                                        //       .doc(widget.userId)
                                        //       .snapshots(),
                                        //   builder: (BuildContext context,
                                        //       AsyncSnapshot<DocumentSnapshot>
                                        //           snapshot) {
                                        //     if (snapshot.connectionState ==
                                        //         ConnectionState.waiting) {
                                        //       return const Center(
                                        //           child: Text(""));
                                        //     }
                                        //     if (snapshot.hasError) {
                                        //       return Text(
                                        //           'Error: ${snapshot.error}');
                                        //     }

                                        //     // Get the user document data
                                        //     var userData = snapshot.data!.data()
                                        //         as Map<String, dynamic>?;
                                        //     double totalAmountGiven = 0;
                                        //     double totalAmountReceived = 0;

                                        //     // Check if the document exists and contains the totalAmountGiven
                                        //     if (userData != null &&
                                        //         userData.containsKey(
                                        //             'totalAmountGiven')) {
                                        //       totalAmountGiven =
                                        //           userData['totalAmountGiven'];
                                        //     }

                                        //     // Check if the document exists and contains the totalAmountReceived
                                        //     if (userData != null &&
                                        //         userData.containsKey(
                                        //             'totalAmountReceived')) {
                                        //       totalAmountReceived = userData[
                                        //           'totalAmountReceived'];
                                        //     }

                                        //     // Calculate the net amount
                                        //     double netAmount =
                                        //         totalAmountGiven -
                                        //             totalAmountReceived;

                                        //     // Now you can use netAmount wherever needed
                                        //     // For example, display it in a Text widget
                                        //     return Text(
                                        //       'Total Balance: ₹ ${netAmount.toInt().abs()}',
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: netAmount >= 0
                                        //             ? Colors.green
                                        //             : Colors.red,
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.userId)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }

                                            // Get the user document data from the snapshot
                                            var userData = snapshot.data!.data()
                                                as Map<String, dynamic>?;

                                            // Get the totalAmountGiven and totalAmountReceived from the fetched data
                                            double totalAmountGiven =
                                                userData?['totalAmountGiven'] ??
                                                    0;
                                            double totalAmountReceived =
                                                userData?[
                                                        'totalAmountReceived'] ??
                                                    0;

                                            // Calculate the net amount
                                            double netAmount =
                                                totalAmountGiven -
                                                    totalAmountReceived;

                                            // Update netAmount to a collection and add timestamp to Firestore
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.userId)
                                                .collection('netAmounts')
                                                .add({
                                              'userId': widget.userId,
                                              'netAmount': netAmount,
                                              'timestamp':
                                                  FieldValue.serverTimestamp(),
                                            }).then((value) {
                                              print(
                                                  'Net amount updated successfully');
                                            }).catchError((error) {
                                              print(
                                                  'Failed to update net amount: $error');
                                            });

                                            // Return your UI widget
                                            return Text(
                                              'Total Balance: ₹ ${netAmount.toInt().abs()}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: netAmount >= 0
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            );
                                          },
                                        ),
                                        // Text(
                                        //   "₹ 50",
                                        //   style: TextStyle(color: Colors.green),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            Expanded(
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cash in Hand",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            "Online",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          StreamBuilder<DocumentSnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.userId)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<DocumentSnapshot>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child: Text(""));
                                              }
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              }

                                              // Get the user document data
                                              var userData =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>?;
                                              double totalAmountGiven = 0;
                                              double totalAmountReceived = 0;

                                              // Check if the document exists and contains the totalAmountGiven
                                              if (userData != null &&
                                                  userData.containsKey(
                                                      'totalAmountGiven')) {
                                                totalAmountGiven = userData[
                                                    'totalAmountGiven'];
                                              }

                                              // Check if the document exists and contains the totalAmountReceived
                                              if (userData != null &&
                                                  userData.containsKey(
                                                      'totalAmountReceived')) {
                                                totalAmountReceived = userData[
                                                    'totalAmountReceived'];
                                              }

                                              // Calculate the net amount
                                              double netAmount =
                                                  totalAmountGiven -
                                                      totalAmountReceived;

                                              // Now you can use netAmount wherever needed
                                              // For example, display it in a Text widget
                                              return Text(
                                                '₹ ${netAmount.toInt().abs()}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: netAmount >= 0
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              );
                                            },
                                          ),
                                          // Text(
                                          //   "₹ 50",
                                          //   style: TextStyle(fontSize: 10),
                                          // ),
                                          const Text(
                                            "₹ 0",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            // Expanded(
                            //   child: Container(
                            //       padding: const EdgeInsets.all(8),
                            //       decoration: BoxDecoration(
                            //           border: Border.all(),
                            //           borderRadius: BorderRadius.circular(5)),
                            //       child: const Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Text(
                            //                 "Cash in Hand",
                            //                 style: TextStyle(fontSize: 10),
                            //               ),
                            //               Text(
                            //                 "Online",
                            //                 style: TextStyle(fontSize: 10),
                            //               ),
                            //             ],
                            //           ),
                            //           Column(
                            //             children: [
                            //               Text(
                            //                 "₹ 50",
                            //                 style: TextStyle(fontSize: 10),
                            //               ),
                            //               Text(
                            //                 "₹ 0",
                            //                 style: TextStyle(fontSize: 10),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       )),
                            // ),
                          ]),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => CashbookReport(
                                        userid: widget.userId,
                                      ))));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.call_to_action_outlined),
                                Text(
                                  "   VIEW CASHBOOK REPORT",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                    height: 45,
                    width: 140,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text("13 MAR", style: TextStyle(fontSize: 10)),
                        // totalentries == null
                        //     ? const Text("")
                        //     : Text("$totalentries Entries",
                        //         style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("IN", style: TextStyle(fontSize: 12)),
                          // Text("₹ 0",
                          //     style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.red)),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: Text(""));
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              // Get the user document data
                              var userData = snapshot.data!.data()
                                  as Map<String, dynamic>?;
                              // Check if the document exists and contains the totalAmountGiven
                              if (userData != null &&
                                  userData.containsKey('totalAmountGiven')) {
                                double totalAmountGiven =
                                    userData['totalAmountGiven'];

                                // Now you can use totalAmountGiven variable wherever needed
                                // For example, display it in a Text widget
                                return Text('₹ ${totalAmountGiven.toInt()}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green));
                              }

                              // Return a default widget if totalAmountGiven is not available
                              return const Text('');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("OUT", style: TextStyle(fontSize: 12)),
                            StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: Text(""));
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              // Get the user document data
                              var userData = snapshot.data!.data()
                                  as Map<String, dynamic>?;
                              // Check if the document exists and contains the totalAmountGiven
                              if (userData != null &&
                                  userData.containsKey('totalAmountReceived')) {
                                double totalAmountReceived =
                                    userData['totalAmountReceived'];

                                // Now you can use totalAmountReceived variable wherever needed
                                // For example, display it in a Text widget
                                return Text('₹ ${totalAmountReceived.toInt()}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red));
                              }

                              // Return a default widget if totalAmountGiven is not available
                              return const Text('');
                            },
                          )
                        
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
                    text: 'IN',
                  ),
                  Tab(text: 'OUT'),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users') // Reference the main collection
                        .doc(
                            widget.userId) // Reference a specific user document

                        .collection(
                            'IN') // Reference the subcollection "youGave"
                        .orderBy('timestamp',
                            descending:
                                true) // Order the documents by timestamp
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Show loading indicator while data is being fetched
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Extract documents from snapshot
                      var transactionsYouGave = snapshot.data!.docs;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                'users') // Reference the main collection
                            .doc(widget
                                .userId) // Reference a specific user document

                            .collection('OUT')
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child:
                                    CircularProgressIndicator()); // Show loading indicator while data is being fetched
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
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userId)
                              .update({
                            'totalAmountGiven': totalAmountGiven
                          }).then((_) {
                            print('Total Amount Given updated successfully!');
                          }).catchError((error) {
                            print(
                                'Failed to update total amount given: $error');
                          });
                          // Calculate total amount received
                          double totalAmountReceived = 0;
                          for (var transaction in transactionsYouGot) {
                            var data =
                                transaction.data() as Map<String, dynamic>?;
                            var amount = data?['amount'];
                            totalAmountReceived += amount;
                          }
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userId)
                              .update({
                            'totalAmountReceived': totalAmountReceived
                          }).then((_) {
                            print('Total Amount Given updated successfully!');
                          }).catchError((error) {
                            print(
                                'Failed to update total amount given: $error');
                          });
                          print(
                              'Total Amount Received: $totalAmountReceived'); // Print total amount received to console
                          print(
                              'Total Amount Given: $totalAmountGiven'); // Print total amount received to console

                          // Calculate net amount
                          // netAmount = totalAmountGiven.toInt() -
                          //     totalAmountReceived.toInt();
                          // FirebaseFirestore.instance
                          //     .collection(
                          //         'users') // Reference the main collection
                          //     .doc(widget
                          //         .userId) // Reference a specific user document
                          //     .collection('Customers')
                          //     .doc(widget.customerId)
                          //     .update({'netAmount': netAmount}).then((_) {
                          //   print('Net Amount updated successfully!');
                          // }).catchError((error) {
                          //   print('Failed to update net amount: $error');
                          // });
                          // print("${netAmount}===========");

                          return ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: transactionsYouGave.length,
                            itemBuilder: (context, index) {
                              var transaction1 = transactionsYouGave[index]
                                  .data() as Map<String, dynamic>?;
                              // var transaction2 = transactionsYouGot[index].data()
                              //     as Map<String, dynamic>?;
                              var docId1 = transactionsYouGave[index].id;
                              // var docId2 = transactionsYouGot[index].id;
                              print("${docId1}__________________");
                              totalentries = transactionsYouGave.length +
                                  transactionsYouGot.length;
                              print('${totalentries}***');
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              CashbookEntryDetails(
                                                                details:
                                                                    '${transaction1['details'] ?? ''}',
                                                                docId: docId1,
                                                                userId: widget
                                                                    .userId,
                                                                color: myColor,
                                                                date: formattedTimestamp1
                                                                    .toString(),
                                                                Amount:
                                                                    '${transaction1['amount'].toInt()}',
                                                              ))));
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
                                                              // Text(
                                                              //   formattedTimestamp1
                                                              //       .toString(),
                                                              //   style: const TextStyle(
                                                              //       color: Colors
                                                              //           .grey,
                                                              //       fontSize:
                                                              //           11),
                                                              // ),
                                                                transaction1![
                                                                          'details'] ==
                                                                      null
                                                                  ? Column( crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                      children: [
                                                                        Text(
                                                                          formattedTimestamp1,
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Column( crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                      children: [
                                                                        Text(
                                                                          formattedTimestamp1
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        ),
                                                                        Text(
                                                                          '${transaction1['details']}',
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        )
                                                                      ],
                                                                    ),
                                                              Padding(
                                                                padding: const EdgeInsets
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
                                                         
                                                          color: Colors
                                                              .transparent,
                                                          child: Center(
                                                            child: Text(
                                                              "₹ ${transaction1['amount'].toInt()}",
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
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users') // Reference the main collection
                        .doc(
                            widget.userId) // Reference a specific user document

                        .collection('IN')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Show loading indicator while data is being fetched
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      // Extract documents from snapshot
                      var transactionsYouGave = snapshot.data!.docs;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(
                                'users') // Reference the main collection
                            .doc(widget
                                .userId) // Reference a specific user document

                            .collection('OUT')
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child:
                                    CircularProgressIndicator()); // Show loading indicator while data is being fetched
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

                          return ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: transactionsYouGot.length,
                            itemBuilder: (context, index) {
                              var transaction2 = transactionsYouGot[index]
                                  .data() as Map<String, dynamic>?;
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  print( transaction2![
                                                                          'details']);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              CashbookEntryDetails(
                                                                details:
                                                                    '${transaction2['details'] ?? ''}',
                                                                docId: docId2,
                                                                userId: widget
                                                                    .userId,
                                                                color: myColor1,
                                                                date: formattedTimestamp2
                                                                    .toString(),
                                                                Amount:
                                                                    '${transaction2['amount'].toInt()}',
                                                              ))));
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
                                                                  ? Column( crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                      children: [
                                                                        Text(
                                                                          formattedTimestamp2,
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Column( crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                      children: [
                                                                        Text(
                                                                          formattedTimestamp2
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        ),
                                                                        Text(
                                                                          '${transaction2['details']}',
                                                                          style: const TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 11),
                                                                        )
                                                                      ],
                                                                    ),
                                                              Padding(
                                                                padding: const EdgeInsets
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
                                                          height: 60,
                                                          color: Colors
                                                              .transparent,
                                                          child: Center(
                                                            child: Text(
                                                              "₹ ${transaction2['amount'].toInt()}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red,
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

            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       // Container styling for youGave items
            //         child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: InkWell(
            //               onTap: () {

            //               },
            //               child: Container(
            //                 width: double.infinity,
            //                 decoration: BoxDecoration(
            //                   borderRadius:
            //                   BorderRadius.circular(10),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.grey
            //                           .withOpacity(0.2),
            //                       spreadRadius: 4,
            //                       blurRadius: 3,
            //                       offset: const Offset(0,
            //                           1), // changes position of shadow
            //                     ),
            //                   ],
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 2,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.white,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment
            //                               .center,
            //                           children: [
            //                             Text(
            //                             'kk',
            //                               style:
            //                               const TextStyle(
            //                                   color: Colors
            //                                       .grey,
            //                                   fontSize:
            //                                   11),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 1,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.transparent,
            //                         child: Center(
            //                           child: Text(
            //                             "BB",
            //                             style: const TextStyle(
            //                                 color: Colors.red,
            //                                 fontWeight:
            //                                 FontWeight
            //                                     .bold),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 1,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.white,
            //                         // Add your content for the third part here
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             )))),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       // Container styling for youGave items
            //         child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: InkWell(
            //               onTap: () {

            //               },
            //               child: Container(
            //                 width: double.infinity,
            //                 decoration: BoxDecoration(
            //                   borderRadius:
            //                   BorderRadius.circular(10),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.grey
            //                           .withOpacity(0.2),
            //                       spreadRadius: 4,
            //                       blurRadius: 3,
            //                       offset: const Offset(0,
            //                           1), // changes position of shadow
            //                     ),
            //                   ],
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 2,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.white,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment
            //                               .center,
            //                           children: [
            //                             const SizedBox(
            //                               height: 12,
            //                             ),
            //                             Text(
            //                            'XX',
            //                               style:
            //                               const TextStyle(
            //                                   color: Colors
            //                                       .grey,
            //                                   fontSize:
            //                                   11),
            //                             ),
            //                             const SizedBox(
            //                               height: 5,
            //                             ),
            //                             Container(
            //                               // color: Colors
            //                               //     .red.shade100,
            //                               child: Padding(
            //                                 padding:
            //                                 const EdgeInsets
            //                                     .symmetric(
            //                                     horizontal:
            //                                     2.0),
            //                                 child: Text(
            //                                   "CC",
            //                                   style: const TextStyle(
            //                                       color: Colors
            //                                           .grey,
            //                                       fontSize:
            //                                       12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 1,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.transparent,
            //                         child: const Center(
            //                           child: Text(
            //                             "",
            //                             style: TextStyle(
            //                                 color: Colors.red,
            //                                 fontWeight:
            //                                 FontWeight
            //                                     .bold),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Expanded(
            //                       flex: 1,
            //                       child: Container(
            //                         height: 60,
            //                         color: Colors.white,
            //                         child: Center(
            //                             child: Text(
            //                               "YY",
            //                               style: const TextStyle(
            //                                   color:
            //                                   Colors.green),
            //                             )),
            //                         // Add your content for the third part here
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             )))),
          ],
        ),
      ),
    );
  }
}
