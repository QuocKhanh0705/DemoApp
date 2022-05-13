import 'package:flutter/material.dart';
import 'package:quockhanh_crud_sample/rest_api.dart';

import 'contact.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _contactName = TextEditingController();
  final _contactEmail = TextEditingController();
  final _contactPhone = TextEditingController();
  final _contactAddress = TextEditingController();
  final _contactAge = TextEditingController();
  final _contactDescription = TextEditingController();
  final _contactNote = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as Contact;
    _contactName.text = contact.name;
    _contactEmail.text = contact.email;
    _contactPhone.text = contact.phone;
    _contactAddress.text = contact.address;
    _contactAge.text = contact.dob;
    _contactDescription.text = contact.description;
    _contactNote.text = contact.note;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit contact'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _contactName,
                decoration: InputDecoration(hintText: 'Fullname'),
              ),
              TextField(
                controller: _contactPhone,
                decoration: InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _contactEmail,
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _contactAddress,
                decoration: InputDecoration(hintText: 'Address'),
                keyboardType: TextInputType.streetAddress,
              ),
              TextField(
                controller: _contactDescription,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              TextField(
                controller: _contactAge,
                decoration: InputDecoration(hintText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _contactNote,
                decoration: InputDecoration(hintText: 'Note'),
              ),
              RaisedButton(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final Map<String, String> queryParams = {
                    "id": contact.id.toString(),
                    "p0": _contactName.text,
                    "p1": _contactPhone.text,
                    "p2": _contactEmail.text,
                    "p3": _contactAddress.text,
                    "p4": _contactDescription.text,
                    "p5": _contactAge.text,
                    "p6": _contactNote.text,
                    'tokenup': 'lethibaotran'
                  };
                  ApiService.updateContact(queryParams).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: const Text('Contact has been update!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    } else {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: const Text('Error Updating Contact!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
