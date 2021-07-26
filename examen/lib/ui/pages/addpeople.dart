import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/peoples.dart';
import 'package:flutter/material.dart';

class AddPeoplePage extends StatefulWidget {
  @override
  _AddPeoplePageState createState() => _AddPeoplePageState();
}

class _AddPeoplePageState extends State<AddPeoplePage> {
  List<Peoples> peoples = [];
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _userController = TextEditingController();

  TextEditingController _countryController = TextEditingController();

  TextEditingController _stateController = TextEditingController();

  TextEditingController _generController = TextEditingController();

  @override
  void initState() {
    _loadData(context);
    super.initState();
  }

  void _loadData(BuildContext context) async {
    List<Peoples> auxpeoples = await DatabaseHelper.database.getAllPeoples();
    print(auxpeoples);
    setState(() {
      auxpeoples = peoples;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add People"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 2.0),
            _inputUser(),
            SizedBox(height: 2.0),
            _inputCountry(),
            SizedBox(height: 2.0),
            _inputlabelState(),
            SizedBox(height: 2.0),
            _inputGener(),
            _buttonAdd()
          ],
        ),
      ),
    );
  }

  Widget _inputUser() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _userController,
        decoration: InputDecoration(
          hintText: 'enter user',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid text';
          }
          return null;
        },
        onSaved: (value) => setState(() => _userController.text = value),
      ),
    );
  }

  Widget _inputCountry() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _countryController,
        decoration: InputDecoration(
          hintText: 'enter country',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid text';
          }
          return null;
        },
        onSaved: (value) => setState(() => _countryController.text = value),
      ),
    );
  }

  Widget _inputlabelState() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _stateController,
        decoration: InputDecoration(
          hintText: 'enter state',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid text';
          }
          return null;
        },
        onSaved: (value) => setState(() => _stateController.text = value),
      ),
    );
  }

  Widget _inputGener() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _generController,
        decoration: InputDecoration(
          hintText: 'enter gener',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid text';
          }
          return null;
        },
        onSaved: (value) => setState(() => _generController.text = value),
      ),
    );
  }

  Widget _buttonAdd() {
    return ElevatedButton(
        child: Text("add"),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            await DatabaseHelper.database.addPeopleToDatabase(Peoples(
                nameuser: _userController.text,
                country: _countryController.text,
                state: _stateController.text,
                gener: _generController.text));
            Navigator.of(context)
                .pushNamed("/form")
                .then((value) => setState(() {
                      _loadData(context);
                    }));
          } else {
            return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("No se pude registrar"),
              backgroundColor: Colors.red,
            ));
          }
        });
  }
}
