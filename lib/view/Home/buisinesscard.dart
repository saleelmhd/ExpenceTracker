import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BuisinessCard extends StatefulWidget {
  String userid;
  BuisinessCard({Key? key, required this.userid}) : super(key: key);

  @override
  State<BuisinessCard> createState() => _BuisinessCardState();
}

class _BuisinessCardState extends State<BuisinessCard> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> imageList = [
    {
      "Image": "images/Bcardimg1.jpg",
      "Text": "Name",
      "Phone": "987654123",
    },
    {
      "Image": "images/Bcardimg2.jpg",
      "Text": "Name",
      "Phone": "321456987",
    },
    {
      "Image": "images/Bcardimg3.webp",
      "Text": "Name",
      "Phone": "753258961",
    }
  ];
  List<GlobalKey> containerKeys = []; // List to store GlobalKey instances

  @override
  void initState() {
    super.initState();
    // Initialize containerKeys list with GlobalKey instances
    for (int i = 0; i < imageList.length; i++) {
      containerKeys.add(GlobalKey());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // StreamBuilder<DocumentSnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('users')
          //         .doc(widget.userid)
          //         .snapshots(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<DocumentSnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Text('Error: ${snapshot.error}');
          //       }

          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       }

          //       // Extracting data from snapshot
          //       var userData = snapshot.data!.data() as Map<String, dynamic>?;
          //       ;
          //       var phoneNo = userData!['phoneNo'];

          //       return Text('${phoneNo}',
          //           style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black));
          //     }),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            items: imageList.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item = entry.value;

              return Center(
                child: Card(
                  child: RepaintBoundary(
                    key: containerKeys[index],
                    child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(item["Image"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: _selectedIndex == 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(widget.userid)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }

                                          // Extracting data from snapshot
                                          var userData = snapshot.data!.data()
                                              as Map<String, dynamic>?;
                                          ;
                                          var phoneNo = userData!['phoneNo'];
                                          var businessName =
                                              userData!['businessName'];

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('${phoneNo ?? ''}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              Text('${businessName ?? ''}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ],
                                          );
                                        }),
                                    // Text(
                                    //   item["Phone"],
                                    //   style: const TextStyle(
                                    //     color: Colors.indigo,
                                    //     fontSize: 15,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            : _selectedIndex == 1
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder<DocumentSnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.userid)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<DocumentSnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }

                                              // Extracting data from snapshot
                                              var userData =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>?;
                                              ;
                                              var phoneNo =
                                                  userData!['phoneNo'];
                                              var businessName =
                                                  userData!['businessName'];

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('${businessName ?? ''}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text('${phoneNo ?? ''}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              );
                                            }),
                                        // Text(
                                        //   item["Phone"],
                                        //   style: const TextStyle(
                                        //     color: Colors.indigo,
                                        //     fontSize: 15,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )
                                : _selectedIndex == 2
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(widget.userid)
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}');
                                                  }

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircularProgressIndicator();
                                                  }

                                                  // Extracting data from snapshot
                                                  var userData = snapshot.data!
                                                          .data()
                                                      as Map<String, dynamic>?;
                                                  ;
                                                  var phoneNo =
                                                      userData!['phoneNo'];
                                                  var businessName =
                                                      userData!['businessName'];

                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          '${businessName ?? ''}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                      Text('${phoneNo ?? ''}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  );
                                                }),
                                            // Text(
                                            //   item["Phone"],
                                            //   style: const TextStyle(
                                            //     color: Colors.indigo,
                                            //     fontSize: 15,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    : Container()),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              final int index = entry.key;
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _selectedIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.indigo,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _downloadImage(_selectedIndex,
                          containerKeys[_selectedIndex], context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download),
                        SizedBox(
                          width: 10,
                        ),
                        Text("DOWNLOAD"),
                      ],
                    ),
                  ),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     _downloadImage(
                //         _selectedIndex, containerKeys[_selectedIndex], context);
                //   },
                //   icon: const Icon(Icons.file_download),
                //   label: const Text('Download'),
                // ),
                const SizedBox(width: 10),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     _shareImage(_selectedIndex, containerKeys[_selectedIndex]);
                //   },
                //   icon: const Icon(Icons.share),
                //   label: const Text('Share'),
                // ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      _shareImage(
                          _selectedIndex, containerKeys[_selectedIndex]);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share),
                        SizedBox(
                          width: 10,
                        ),
                        Text("SHARE"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _shareImage(int index, GlobalKey containerKey) async {
    try {
      Uint8List? imageBytes = await captureWidgetToImage(containerKey);
      if (imageBytes != null) {
        final String fileName =
            'image_$index.png'; // You can customize the file name
        final String path = await _saveImage(imageBytes, fileName);
        if (path.isNotEmpty) {
          // Download successful, now share the image
          await Share.shareFiles([path],
              text: 'Check out this image from my app!');
        } else {
          // Unable to save image
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to download image.'),
          ));
        }
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred.'),
      ));
    }
  }

  Future<Uint8List?> captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print("Error capturing widget: $e");
      return null;
    }
  }

  Future<String> _saveImage(Uint8List bytes, String fileName) async {
    try {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/$fileName';
      await File(filePath).writeAsBytes(bytes);
      return filePath;
    } catch (e) {
      print("Error saving image: $e");
      return '';
    }
  }

  Future<void> _downloadImage(
      int index, GlobalKey containerKey, BuildContext context) async {
    try {
      Uint8List? imageBytes = await captureWidgetToImage(containerKey);
      if (imageBytes != null) {
        final String fileName =
            'image_$index.png'; // You can customize the file name
        final String path = await _saveImg(imageBytes, fileName);
        if (path.isNotEmpty) {
          // Download successful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image downloaded successfully!')),
          );
        } else {
          // Unable to save image
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to download image.')),
          );
        }
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    }
  }

  Future<String> _saveImg(Uint8List imageBytes, String fileName) async {
    try {
      final directory = await getExternalStorageDirectory();
      final imagePath = '${directory!.path}/$fileName';
      final result = await ImageGallerySaver.saveImage(
        imageBytes,
        name: fileName,
      );
      return result['filePath'] ?? '';
    } catch (e) {
      print("Error saving image: $e");
      return '';
    }
  }
}
