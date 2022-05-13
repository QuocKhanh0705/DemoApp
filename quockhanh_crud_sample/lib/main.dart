import 'package:flutter/material.dart';
import 'package:quockhanh_crud_sample/add_screen.dart';
import 'package:quockhanh_crud_sample/rest_api.dart';

import 'contact.dart';
import 'detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ContactScreen(),
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuocKhanh 18DH110953'),
      ),
      body: FutureBuilder(
        future: ApiService.getContact(),
        builder: (context, snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.connectionState == ConnectionState.done) {
              final contacts = snapshot.data as List<Contact>;
              return buildListView(contacts);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildItem(contacts, index);
      },
      itemCount: contacts.length,
    );
  }

  Dismissible buildItem(List<Contact> contacts, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Do you want to delete this contact'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ApiService.deleteContact(contacts[index].id)
                          .then((success) {
                        if (success) {
                          showDialog(
                            builder: (context) => AlertDialog(
                              title: const Text('Contact has been removed!!!'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: const Text('OK'),
                                )
                              ],
                            ),
                            context: context,
                          );
                        } else {
                          showDialog(
                            builder: (context) => AlertDialog(
                              title: const Text('Error Removing Contact!!!'),
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
                        }
                      });
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No'),
                  )
                ],
              );
            });
      },
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              contacts[index].id.toString(),
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
          title: Text(contacts[index].name),
          subtitle: Text(contacts[index].phone),
          trailing: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(),
                settings: RouteSettings(arguments: contacts[index])
              ),
            );
          },
        ),
      ),
    );
  }
}
