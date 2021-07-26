import 'package:examen/dataDB/database_helper.dart';

import 'package:examen/models/peoples.dart';
import 'package:examen/provider/auth.dart';
import 'package:examen/utils/popoptionmenui.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
  FormPage({this.authStateListener, this.authStateProvider});
  final AuthStateListener authStateListener;
  final AuthStateProvider authStateProvider;
}

class _FormPageState extends State<FormPage> {
  void _signOut() async {
    try {
      widget.authStateProvider.notify(AuthState.LOGGED_OUT);

      widget.authStateListener.onAuthStateChanged(AuthState.LOGGED_OUT);
    } catch (e) {
      print(e);
    }
  }

  final _sacaffoldKey = new GlobalKey<ScaffoldState>();

  List allPeoples = [];
  List items = [];
  TextEditingController textSearch = TextEditingController();

  @override
  void didUpdateWidget(FormPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper.database.getAllPeoples().then((peoples) {
      setState(() {
        allPeoples = peoples;
        items = allPeoples;
      });
    });
  }

  void filterSearch(String querry) async {
    var searchList = allPeoples;
    if (querry.isNotEmpty) {
      var listData = [];
      searchList.forEach((item) {
        var peoples = Peoples.map(item);
        if (peoples.nameuser.toLowerCase().contains(querry.toLowerCase())) {
          listData.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(listData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allPeoples;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _sacaffoldKey,
        appBar: AppBar(
          title: Text("List of regist"),
          actions: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                PopOptionMenu(),
              ],
            )
          ],
        ),
        drawer: _drawerPersonalize(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/addpeople');
            }),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                  controller: textSearch,
                  onChanged: (value) {
                    setState(() {
                      filterSearch(value);
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "enter search",
                      prefixIcon: Icon(Icons.search))),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    Peoples model = (items[index]);
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
                  }),
            )
          ],
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
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Ajustes'),
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
