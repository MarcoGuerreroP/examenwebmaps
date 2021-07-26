import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/peoples.dart';
import 'package:flutter/material.dart';

class GetUserPage extends StatefulWidget {
  GetUserPage({Key key}) : super(key: key);

  @override
  _GetUserPageState createState() => _GetUserPageState();
}

class _GetUserPageState extends State<GetUserPage> {
// ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    Peoples auxModel;
    Peoples model = auxModel;

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DatabaseHelper.database.getPeopleWithName(model.nameuser),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    auxModel = snapshot.data[index];
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
}
