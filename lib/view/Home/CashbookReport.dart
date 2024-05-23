import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CashbookReport extends StatefulWidget {
  String userid;
  CashbookReport({super.key, required this.userid});

  @override
  State<CashbookReport> createState() => _CashbookReportState();
}

class _CashbookReportState extends State<CashbookReport> {
  DateTime? latestDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white),
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.picture_as_pdf_outlined),
              SizedBox(
                width: 10,
              ),
              Text("DOWNLOAD"),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          "Cashbook Report",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
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
                    height: 50,
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
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          child: const Row(
                            children: [
                              Text(
                                "    Select report duration",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.blue[100],
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                " THIS MONTH ",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(fontSize: 11),
                    ),
                    // Text(
                    //   "DAILY BALANCE",
                    //   style: TextStyle(fontSize: 11),
                    // ),
                    SizedBox(),
                    Text(
                      "TOTAL BALANCE",
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              )),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userid)
                .collection('netAmounts')
                .orderBy('timestamp',
                    descending: true) // Order by timestamp in descending order
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  // Timestamp timestamp = document['timestamp'];
                  // DateTime dateTime = timestamp.toDate();
                  // String formattedDateTime =
                  //     DateFormat('dd MMM HH:mm').format(dateTime);
                  // double netAmount = document['netAmount'];
                  Timestamp timestamp = document['timestamp'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDateTime =
                      DateFormat('dd MMM HH:mm').format(dateTime);
                  double netAmount = document['netAmount'];
                  if (latestDateTime == null ||
                      !isSameDay(dateTime, latestDateTime!)) {
                    latestDateTime = dateTime; // Update latestDateTime
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Deletion"),
                                content: const Text(
                                    "Are you sure you want to delete this document?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          false); // Dismiss the dialog and do not delete
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(
                                          true); // Dismiss the dialog and delete
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.userid)
                              .collection('netAmounts')
                              .doc(document.id)
                              .delete()
                              .then((_) {
                            print("Document successfully deleted!");
                          }).catchError((error) {
                            print("Error deleting document: $error");
                          });
                        },
                        child: Card(
                          elevation: 0,
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 228, 227, 227),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Display formatted date and time
                                  Text(formattedDateTime),
                                  // Display net amount
                                  Text(
                                    '₹ ${netAmount.toInt().abs()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: netAmount >= 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink(); // Hide the item if netAmount is 0
                  }
                },
              ));
            },
          )
        ],
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

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
