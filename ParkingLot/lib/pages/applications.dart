import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/login.dart';
import 'package:parkinglot/services/application_service.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  _ApplicationsPageState createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  final _appStream =
      FirebaseFirestore.instance.collection('Applications').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                return Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (Route<dynamic> route) => false);
              });
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _appStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                color: Colors.white70,
                shadowColor: Colors.black,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(data['ParkingLotName']),
                      subtitle: (Text('${data['Email']}')),
                    ),
                    ListTile(
                      title: Text('${data['County']} / ${data['City']}'),
                      subtitle: Text('${data['Address']}'),
                    ),
                    ListTile(
                      title: Text('Hourly Fee: \$${data['HourlyFee']}'),
                      subtitle: Text(
                        'Capacity: ${data['Capacity']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to DENY the application'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        denyApplication(data['Email']);
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text(
                              'Deny',
                              style: TextStyle(fontSize: 16),
                            )),
                        const SizedBox(width: 15),
                        TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to ACCEPT the application'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        acceptApplication(data['Email']);
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text(
                              'Accept',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
