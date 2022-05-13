import 'package:flutter/material.dart';
import 'package:quockhanh_crud_sample/contact.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail contact"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContact(),
                    settings: RouteSettings(arguments: contact)
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              buildHeader(context, contact.name),
              buildInformation(contact)
            ],
          )
        ],
      ),
    );
  }

  Container buildHeader(BuildContext context, String name) {
    return Container(
      decoration: BoxDecoration(color: Colors.indigo),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          SizedBox(height: 20),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildInformation(Contact contact) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(contact.phone),
              subtitle: Text(
                "Phone Number",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: Icon(Icons.phone, color: Colors.indigo),
                onPressed: () {
                  _launchCaller(contact.phone);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  // _textMe(phoneNumber);
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(contact.email),
              subtitle: Text(
                "Email",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.email, color: Colors.indigo),
                  onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(contact.address),
              subtitle: Text(
                "Address",
                style: TextStyle(color: Colors.black54),
              ),
              leading: Icon(Icons.location_city, color: Colors.indigo),
            ),
          ),
          Card(
              child: ListTile(
            title: Text(contact.dob),
            subtitle: Text(
              "DOB",
              style: TextStyle(color: Colors.black54),
            ),
            leading: Icon(Icons.cake, color: Colors.indigo),
          )),
        ],
      ),
    );
  }

  _launchCaller(String number) async {
    String url = "tel:$number";
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
