import 'package:flutter/material.dart';
import 'package:mongodb/CRDU/insert.dart';

import '../MongoDbModel.dart';
import '../dbHelper/mongodb.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
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
                    return displayCard(
                        MongoDbModel.fromJson(snapshot.data[index]));
                  },
                );
              } else {
                return const Center(
                  child: Text('no data Found'),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModel dbModel) {
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
                        settings: RouteSettings(arguments: dbModel)),
                  ).then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
