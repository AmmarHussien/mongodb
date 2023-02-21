import 'package:flutter/material.dart';
import 'package:mongodb/MongoDbModel.dart';
import 'package:mongodb/dbHelper/mongodb.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
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
                  child: Text('no data avalibale'),
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
        child: Column(
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
      ),
    );
  }
}
