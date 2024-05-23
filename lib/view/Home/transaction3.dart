// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class CombinedList extends StatefulWidget {
//   String name;
//   String number;
//   String customerId;
//   String userId;
//   CombinedList(
//       {super.key,
//       required this.name,
//       required this.customerId,
//       required this.number,
//       required this.userId});

//   @override
//   State<CombinedList> createState() => _CombinedListState();
// }

// class _CombinedListState extends State<CombinedList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users') // Reference the main collection
//             .doc(widget.userId) // Reference a specific user document
//             .collection('Customers')
//             .doc(widget.customerId)
//             .collection('youGot')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
//           if (!snapshot1.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('users') // Reference the main collection
//                 .doc(widget.userId) // Reference a specific user document
//                 .collection('Customers')
//                 .doc(widget.customerId)
//                 .collection('youGave')
//                 .orderBy('timestamp', descending: true)
//                 .snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
//               if (!snapshot2.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               // Merge both snapshots into one list
//               List<DocumentSnapshot> combinedList = [];
//               combinedList.addAll(snapshot1.data!.docs);
//               combinedList.addAll(snapshot2.data!.docs);

//               // Sort the combined list by a common field, e.g., timestamp
//               combinedList
//                   .sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: combinedList.length,
//                 itemBuilder: (context, index) {
//                   // Here you can build your list item using combinedList[index]
//                   return ListTile(
//                     // title: Text(combinedList[index]['title']),
//                     // Add more fields as needed
//                     // title: Text(combinedList[index]['amount']),
//                      subtitle: Text(double.parse(combinedList[index]['amount'].toString()).toString()),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
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

class CombinedList extends StatefulWidget {
  String name;
  String number;
  String customerId;
  String userId;
  CombinedList({
    super.key,
    required this.name,
    required this.number,
    required this.userId,
    required this.customerId,
  });

  @override
  State<CombinedList> createState() => _CombinedListState();
}

class _CombinedListState extends State<CombinedList> {
  final List<Color> tabColors = [
    Colors.red,
    Colors.green
  ]; // Define colors for each tab
  int _selectedIndex = 0; // Variable to track the selected tab index

  double? netAmount = 0.0;
  bool isGaveSelected = false;

  late List<Map<String, dynamic>>
      transactions; // List to store transaction data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: const Icon(Icons.call))
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
                        double netAmount = customerData['netAmount'];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                netAmount == 0
                                    ? const Text("Settled up")
                                    : netAmount > 0
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
                                      netAmount < 0 ? Colors.red : Colors.green,
                                ),
                              ],
                            ),
                            netAmount == 0.0
                                ? const Text("0")
                                : netAmount < 0
                                    ? Text(
                                        '${netAmount < 0 ? '' : ''} ₹ ${netAmount.abs().toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        '₹ ${netAmount.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                          ],
                        );
                      } else {
                        return const Text('Net Amount: N/A');
                      }
                    },
                  ),
//                   StreamBuilder<DocumentSnapshot>(
//   stream: FirebaseFirestore.instance
//       .collection('users')
//       .doc(widget.userId)
//       .collection('Customers')
//       .doc(widget.customerId)
//       .snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     }
//     if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     }

//     // Get the customer document data
//     var customerData = snapshot.data!.data() as Map<String, dynamic>?;

//     // Check if the document exists and contains the netAmount
//     if (customerData != null && customerData.containsKey('netAmount')) {
//       double netAmount = customerData['netAmount'];

//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               if (netAmount == 0)
//                 const Text("Settled up")
//               else if (netAmount < 0)
//                 const Text(
//                   "You will give",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 )
//               else
//                 const Text(
//                   "You will get",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               Icon(
//                 netAmount < 0 ? Icons.emoji_emotions : Icons.emoji_emotions_outlined,
//                 color: netAmount < 0 ? Colors.green : Colors.red,
//               ),
//             ],
//           ),
//           // Text(
//           //   '${netAmount == 0 ? '0' : '₹ ${netAmount.abs().toStringAsFixed(netAmount.abs() == netAmount.toInt() ? 0 : 2)}'}',
//           //   style: TextStyle(
//           //     fontWeight: FontWeight.bold,
//           //     color: netAmount < 0 ? Colors.red : Colors.green,
//           //   ),
//           // ),

//         ],
//       );
//     } else {
//       return const Text('Net Amount: N/A');
//     }
//   },
// ),
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
          // Container(
          //   // Container for the TabBar
          //   decoration: BoxDecoration(
          //     color: tabColors[_selectedIndex], // TabBar background color
          //     borderRadius: BorderRadius.circular(8.0), // Rounded corners
          //   ),
          //   margin: const EdgeInsets.all(10.0), // Margin for the container
          //   child: TabBar(
          //     unselectedLabelStyle: const TextStyle(color: Colors.black),
          //     labelStyle: const TextStyle(
          //         color: Colors
          //             .white), // Set label color based on selected tab index
          //     onTap: (index) {
          //       setState(() {
          //         _selectedIndex = index; // Update selected tab index
          //       });
          //     },
          //     tabs: const [
          //       Tab(
          //         text: 'You Gave',
          //       ),
          //       Tab(text: 'You Got'),
          //     ],
          //   ),
          // ),

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users') // Reference the main collection
                .doc(widget.userId) // Reference a specific user document
                .collection('Customers')
                .doc(widget.customerId)
                .collection('youGot')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              if (!snapshot1.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users') // Reference the main collection
                    .doc(widget.userId) // Reference a specific user document
                    .collection('Customers')
                    .doc(widget.customerId)
                    .collection('youGave')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (!snapshot2.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  double totalGot = snapshot1.data!.docs.fold(
                    0,
                    (prev, doc) =>
                        prev + double.parse(doc['amount'].toString()),
                  );

                  // Calculate total amount gave
                  double totalGave = snapshot2.data!.docs.fold(
                    0,
                    (prev, doc) =>
                        prev + double.parse(doc['amount'].toString()),
                  );

                  // Calculate net amount
                  netAmount = totalGot - totalGave;
                  FirebaseFirestore.instance
                      .collection('users') // Reference the main collection
                      .doc(widget.userId) // Reference a specific user document
                      .collection('Customers')
                      .doc(widget.customerId)
                      .update({'netAmount': netAmount}).then((_) {
                    print('Net Amount updated successfully!');
                  }).catchError((error) {
                    print('Failed to update net amount: $error');
                  });
                  print("${netAmount}===========");
                  // Merge both snapshots into one list
                  List<DocumentSnapshot> combinedList = [];
                  combinedList.addAll(snapshot1.data!.docs);
                  combinedList.addAll(snapshot2.data!.docs);
                  // Sort the combined list by a common field, e.g., timestamp
                  // Sort the combined list by timestamp
                  // combinedList.sort((a, b) => (b['timestamp'] as Timestamp)
                  //     .compareTo(a['timestamp'] as Timestamp));
                  combinedList.sort((a, b) {
                    // Check if timestamp is null
                    if (a['timestamp'] == null || b['timestamp'] == null) {
                      // Put null values at the end
                      return a['timestamp'] == null ? 1 : -1;
                    }
                    // Compare timestamps
                    return (b['timestamp'] as Timestamp)
                        .compareTo(a['timestamp'] as Timestamp);
                  });
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: combinedList.length,
                      itemBuilder: (context, index) {
                        Color textColor = combinedList[index]
                                .reference
                                .path
                                .contains('youGot')
                            ? Colors.green
                            : Colors.red;
                        String formattedDateTime = '';
                        if (combinedList[index] is DocumentSnapshot) {
                          DocumentSnapshot document =
                              combinedList[index] as DocumentSnapshot;
                          if (document['timestamp'] != null) {
                            var timestamp = document['timestamp'];
                            var date = timestamp.toDate();
                            formattedDateTime =
                                DateFormat('dd MMM yy • hh:mm a').format(date);
                          }
                        }
                        Map<String, dynamic> data =
                            combinedList[index].data() as Map<String, dynamic>;
                        // Check if the 'details' key exists in the map
                        String details =
                            data.containsKey('details') ? data['details'] : '';

                        // Here you can build your list item using combinedList[index]
                        // return ListTile(
                        //   // title: Text(combinedList[index]['title']),
                        //   // Add more fields as needed
                        //   // title: Text(combinedList[index]['amount']),
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => EntryDetails(
                        //                   details:
                        //                       '',
                        //                   userId: widget.userId,
                        //                   Customerid: widget.customerId,
                        //                   docId: '${combinedList[index].id}',
                        //                   Amount:
                        //                       '${double.parse(combinedList[index]['amount'].toString()).toString()}',
                        //                   name: widget.name,
                        //                   color: textColor,
                        //                   date: '',
                        //                   number: widget.number,
                        //                 )));
                        //   },
                        //   subtitle: Text(
                        //     double.parse(
                        //             combinedList[index]['amount'].toString())
                        //         .toString(),
                        //     style: TextStyle(color: textColor),
                        //   ),
                        // );
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
                                                          details: details,
                                                          userId: widget.userId,
                                                          Customerid:
                                                              widget.customerId,
                                                          docId: combinedList[
                                                                  index]
                                                              .id,
                                                          Amount: double.parse(
                                                                  combinedList[
                                                                              index]
                                                                          [
                                                                          'amount']
                                                                      .toString())
                                                              .toStringAsFixed(
                                                                  0),
                                                          name: widget.name,
                                                          color: textColor,
                                                          date:
                                                              formattedDateTime,
                                                          number: widget.number,
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
                                                    height: 50,
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // transaction1![
                                                        //             'details'] ==
                                                        //         null
                                                        //     ? Column(
                                                        //         children: [
                                                        //           Text(''

                                                        //                 .toString(),
                                                        //             style: const TextStyle(
                                                        //                 color: Colors
                                                        //                     .grey,
                                                        //                 fontSize:
                                                        //                     11),
                                                        //           ),
                                                        //         ],
                                                        //       )
                                                        //     : Column(
                                                        //         crossAxisAlignment:
                                                        //             CrossAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           Text(''
                                                        //             ,
                                                        //             style: const TextStyle(
                                                        //                 color: Colors
                                                        //                     .grey,
                                                        //                 fontSize:
                                                        //                     11),
                                                        //           ),
                                                        //           Text(
                                                        //             '',
                                                        //             style: const TextStyle(
                                                        //                 color: Colors
                                                        //                     .grey,
                                                        //                 fontSize:
                                                        //                     11),
                                                        //           )
                                                        //         ],
                                                        //       ),

                                                        Text(
                                                          formattedDateTime,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 11),
                                                        ),
                                                        Text(
                                                          details,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    color: Colors.red.shade50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        combinedList[index]
                                                                .reference
                                                                .path
                                                                .contains(
                                                                    'youGave')
                                                            ? Text(
                                                                "₹ ${_formatAmount(combinedList[index]['amount'])} ",
                                                                style: TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                "",
                                                                style: TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: 50,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        combinedList[index]
                                                                .reference
                                                                .path
                                                                .contains(
                                                                    'youGot')
                                                            ? Text(
                                                                "₹ ${_formatAmount(combinedList[index]['amount'])} ",
                                                                style: TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                "",
                                                                style: TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                      ],
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
                    ),
                  );
                },
              );
            },
          ),
        ]));
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
}
