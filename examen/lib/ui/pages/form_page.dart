import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.login_outlined), onPressed: () {}),
        ],
        title: Text("List of regist"),
      ),
      drawer: _drawerPersonalize(),
    );
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
