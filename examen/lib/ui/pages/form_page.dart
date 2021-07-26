import 'package:examen/dataDB/database_helper.dart';
// ignore: unused_import
import 'package:examen/models/peoples.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _sacaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didUpdateWidget(FormPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _sacaffoldKey,
        appBar: AppBar(
          title: Text("List of regist"),
        ),
        drawer: _drawerPersonalize(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/addpeople');
            }),
        body: FutureBuilder(
          future: DatabaseHelper.database.getAllPeoples(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Peoples model = snapshot.data[index];
                    return ListTile(
                      isThreeLine: true,
                      title: Text(
                        'Usuario: ${model.nameuser}',
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pais: ${model.country}',
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Estado: ${model.state}',
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            'Genero: ${model.gener}',
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                      leading: CircleAvatar(child: Text(model.id.toString())),
                    );
                  });
            } else {
              return CircularProgressIndicator(backgroundColor: Colors.green);
            }
          },
        ));
  }

  Widget _drawerPersonalize() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu Items'),
          ),
          ListTile(
            leading: Icon(Icons.backup_outlined),
            title: const Text('Backup SQLITE'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
