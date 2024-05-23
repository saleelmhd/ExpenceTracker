import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensenote/view/Home/editbuisinessname.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.uid});
  String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name Section
            const Text(
              "Personal Info",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            // StreamBuilder<DocumentSnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection('users')
            //       .doc(widget.uid)
            //       .snapshots(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<DocumentSnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Text("");
            //     }

            //     // Extracting data from snapshot
            //     var userData = snapshot.data!.data() as Map<String, dynamic>?;

            //     var userName = userData!['userName'];
            //     var email = userData['email'];

            //     return Column(
            //       children: [
            //         Text('UserName: $userName'),
            //         Text('Email: $email'),
            //       ],
            //     );
            //   },
            // ),

            Card(
              elevation: 5,
              child: ListTile(
                title: const Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                 StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("");
                    }

                    // Extracting data from snapshot
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    var userName = userData!['userName'];
                    var email = userData['email'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$userName'),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Phone Number Section
            Card(
              elevation: 5,
              child: ListTile(
                title: const Text(
                  'Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("");
                    }

                    // Extracting data from snapshot
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    var phoneNo = userData!['phoneNo'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$phoneNo'),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Business Name Section
            InkWell(onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditBusinessNamePage(userId: widget.uid,)));
            },
              child: Card(
                elevation: 5,
                child: ListTile(
                  trailing: const Icon(Icons.arrow_right_alt),
                  title: const Text(
                    'Business Name',
                    style:  TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
              
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("");
                      }
              
                      // Extracting data from snapshot
                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>?;
              
                      var businessName = userData!['businessName'];
                    
              
                      return Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           businessName == null
                      ? Container():
                          Text('$businessName'),
                         
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // Email Section
            Card(
              elevation: 5,
              child: ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("");
                    }

                    // Extracting data from snapshot
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    var userName = userData!['userName'];
                    var email = userData['email'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$email'),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
