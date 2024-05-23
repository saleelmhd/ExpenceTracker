import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactSelectionPage extends StatelessWidget {
  final Iterable<Contact> contacts;

  const ContactSelectionPage({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: contacts.map((contact) {
            return ListTile(
              title: Text(contact.displayName ?? ''),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(contact);
                },
                child: Text("Add"),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
