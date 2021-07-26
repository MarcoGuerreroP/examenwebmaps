import 'package:examen/dataDB/database_helper.dart';
import 'package:examen/models/peoples.dart';
import 'package:flutter/material.dart';

class GetGenerPage extends StatelessWidget {
  const GetGenerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Peoples auxModel;
    Peoples model = auxModel;

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DatabaseHelper.database.getPeopleWithCounty(model.gener),
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
                        'Usuario: ${model.country}',
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
