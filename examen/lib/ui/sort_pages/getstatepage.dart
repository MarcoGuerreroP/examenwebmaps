import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/peoples.dart';
import 'package:flutter/material.dart';

class GetStatePage extends StatefulWidget {
  const GetStatePage({Key key}) : super(key: key);

  @override
  _GetStatePageState createState() => _GetStatePageState();
}

class _GetStatePageState extends State<GetStatePage> {
  @override
  Widget build(BuildContext context) {
    Peoples auxModel;
    Peoples model = auxModel;

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DatabaseHelper.database.getPeopleWithCounty(model.state),
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
                        'Usuario: ${model.state}',
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pais: ${model.nameuser}',
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
