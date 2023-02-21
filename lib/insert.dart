import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb/MongoDbModel.dart';
import 'package:mongodb/dbHelper/mongodb.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fNameController = new TextEditingController();
  var lNameController = new TextEditingController();
  var addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'insert Date',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: fNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: lNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: addressController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _fakeData();
                    },
                    child: const Text('Generate AutoData'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _insertData(
                        fNameController.text,
                        lNameController.text,
                        addressController.text,
                      );
                    },
                    child: const Text('Insert Data'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(
    String fName,
    String lName,
    String address,
  ) async {
    var _id = M.ObjectId();

    final data = MongoDbModel(
      id: _id,
      firstname: fName,
      lastname: lName,
      address: address,
    );
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Inserted Id${_id.$oid}',
        ),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    fNameController.text = '';
    lNameController.text = '';
    addressController.text = '';
  }

  void _fakeData() {
    setState(() {
      fNameController.text = faker.person.firstName();
      lNameController.text = faker.person.lastName();
      addressController.text =
          '${faker.address.streetName()}\n${faker.address.streetAddress()}';
    });
  }
}
