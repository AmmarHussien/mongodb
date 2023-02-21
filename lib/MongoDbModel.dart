import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel welcomeFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String welcomeToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    MongoDbModel({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.address,
    });

    ObjectId id;
    String firstname;
    String lastname;
    String address;

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
    };
}
