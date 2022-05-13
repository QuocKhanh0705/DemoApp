import 'package:flutter/material.dart';
import 'package:quockhanh_crud_sample/rest_api.dart';

class AddContactScreen extends StatefulWidget {
  AddContactScreen({Key? key}) : super(key: key);

  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _contactName = TextEditingController();
  final _contactEmail = TextEditingController();
  final _contactPhone = TextEditingController();
  final _contactAddress = TextEditingController();
  final _contactAge = TextEditingController();
  final _contactDescription = TextEditingController();
  final _contactNote = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
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
                    "p0": _contactName.text,
                    "p1": _contactPhone.text,
                    "p2": _contactEmail.text,
                    "p3": _contactAddress.text,
                    "p4": _contactDescription.text,
                    "p5": _contactAge.text,
                    "p6": _contactNote.text,
                    'tokenin': 'lethibaotran'
                  };
                  ApiService.addContact(queryParams).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: const Text('Contact has been added!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _contactName.text = '';
                                _contactPhone.text = '';
                                _contactEmail.text = '';
                                _contactAddress.text = '';
                                _contactDescription.text = '';
                                _contactAge.text = '';
                                _contactNote.text = '';
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
                          title: const Text('Error Adding Contact!!!'),
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