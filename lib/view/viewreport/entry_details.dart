import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'edit_entry.dart';

class EntryDetails extends StatefulWidget {
  String Amount;
  String name;
  Color color;
  String date;
  String number;
   String details;
  String Customerid;
  String docId;
  String userId;
  EntryDetails(
      {super.key,
      required this.userId,
       required this.details,
      required this.docId,
      required this.date,
      required this.Amount,
      required this.name,
      required this.color,
      required this.number,
      required this.Customerid});

  @override
  State<EntryDetails> createState() => _EntryDetailsState();
}

class _EntryDetailsState extends State<EntryDetails> {
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.red))),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      'Delete entry ?',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Delete entry will change your balance',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor:
                                                      Colors.indigo,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.indigo))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("CANCEL")),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.indigo,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.indigo))),
                                              onPressed: () {
                                                print(
                                                    "${widget.Customerid}===========");
                                                Navigator.of(context).pop();

                                                FirebaseFirestore.instance
                                                    .collection(
                                                        'users') // Reference the main collection
                                                    .doc(widget
                                                        .userId) // Reference a specific user document
                                                    .collection('Customers')
                                                    .doc(widget.Customerid)
                                                    .collection('youGave')
                                                    .doc(widget
                                                        .docId) // Specify the document ID to delete
                                                    .delete()
                                                    .then((_) {
                                                  print(
                                                      'Document deleted successfully..');
                                                }).catchError((error) {
                                                  print(
                                                      'Error deleting document: $error');
                                                });
                                                FirebaseFirestore.instance
                                                 .collection(
                                                        'users') // Reference the main collection
                                                    .doc(widget
                                                        .userId) // Reference a specific user document
                                                    .collection('Customers')
                                                    .doc(widget.Customerid)
                                                    .collection('youGot')
                                                    .doc(widget
                                                        .docId) // Specify the document ID to delete
                                                    .delete()
                                                    .then((_) {
                                                  print(
                                                      'Document deleted successfully');
                                                }).catchError((error) {
                                                  print(
                                                      'Error deleting document: $error');
                                                });

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("CONFIRM")),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                          ),
                          Text("  DELETE"),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.indigo))),
                      onPressed: () {
                        _captureAndShare();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            size: 20,
                          ),
                          Text("  SHARE"),
                        ],
                      )),
                )
              ],
            )),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Text(
            "Entry Details",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.indigo,
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Color(
                                                (Random().nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt() <<
                                                    0)
                                            .withOpacity(1.0),
                                        child: Text(
                                          '${widget.name}'.substring(0, 1),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        // Text(
                                        //   "09 Mar 24 • 01:59 PM",
                                        //   style: TextStyle(fontSize: 11),
                                        // ),
                                        Text(
                                          widget.date,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "₹ ${widget.Amount}",
                                      style: TextStyle(
                                          fontSize: 18, color: widget.color),
                                    ),
                                    widget.color == Colors.red
                                        ? const Text("You gave",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ))
                                        : const Text("You got",
                                            style: TextStyle(
                                              fontSize: 10,
                                            ))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // const Divider(),
                            // const Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Running Balanace",
                            //       style: TextStyle(fontSize: 12),
                            //     ),
                            //     Text(
                            //       "₹ 31",
                            //       style: TextStyle(
                            //           fontSize: 16, color: Colors.red),
                            //     ),
                            //   ],
                            // ),

                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditEntry(
                                      details: widget.details,
                                      userId: widget.userId,
                                      date: widget.date,
                                      name: widget.name,
                                          amount: "${widget.Amount}",
                                          color: widget.color,
                                          docid: widget.docId,
                                          customerid: widget.Customerid,
                                        )));
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.indigo,
                                    ),
                                    Text(
                                      "  EDIT ENTRY",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.message_outlined),
                            Text(
                              "   SMS disabled",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text("You got :  ₹ ${widget.Amount}"),
                        Text("Send by : ${widget.number}"),
                        const SizedBox(
                          height: 15,
                        ),
                     
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.backup,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "   Entry is backed up",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://www.freelancerhelper.com/imgs/secure.png",
                    width: 30,
                  ),
                  const Text(
                    "   100 % Safe and Secure",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _captureAndShare() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/entry.png').create();
        await file.writeAsBytes(pngBytes);

        await Share.shareFiles([file.path],
            text: 'Check out this entry!', subject: 'Share Entry');
      }
    } catch (e) {
      print('Error sharing entry: $e');
    }
  }
}
