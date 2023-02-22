import 'package:flutter/material.dart';
import 'package:mongodb/CRDU/insert.dart';
import 'package:mongodb/MongoDbModel.dart';

import '../dbHelper/mongodb.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                return ListView.builder(
                  itemCount: totalData,
                  itemBuilder: (BuildContext context, int index) {
                    return _dataCard(
                        MongoDbModel.fromJson(snapshot.data[index]));
                  },
                );
              } else {
                return const Center(
                  child: Text('no data avalibale'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _dataCard(MongoDbModel dbModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dbModel.id.$oid),
                const SizedBox(
                  height: 5,
                ),
                Text(dbModel.firstname),
                const SizedBox(
                  height: 5,
                ),
                Text(dbModel.lastname),
                const SizedBox(
                  height: 5,
                ),
                Text(dbModel.address),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MongoDbInsert();
                    },
                    settings: RouteSettings(arguments: dbModel),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                print(dbModel.id);
                await MongoDatabase.delete(dbModel);
                setState(() {
                  
                });
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
