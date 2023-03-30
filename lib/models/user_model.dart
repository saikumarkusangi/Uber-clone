import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? mobile;
  String? name;
  String? id;
  String? address;

  UserModel({this.name,this.address,this.id,this.mobile});

  UserModel.fromSnapshot(DataSnapshot snap)
  {
    mobile = (snap.value as dynamic)['mobile'];
    name = (snap.value as dynamic)['name'];
    id = (snap.value as dynamic)['id'];
    address = (snap.value as dynamic)['address'];
  }
}