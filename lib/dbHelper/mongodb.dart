import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb/MongoDbModel.dart';
import 'package:mongodb/dbHelper/constant.dart';

class MongoDatabase {
  static var db;
  static var userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String,dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel dbModel) async {
    try {
      var result = await userCollection.insertOne(dbModel.toJson());
      if (result.isSuccess) {
        return 'Data inserted';
      } else {
        return 'Something is wrong';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
