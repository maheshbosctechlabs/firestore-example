// Simple CRUD for UserModel

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/models/user_model.dart';

class UserRepository {
  //Connect to collection
  final CollectionReference collection  = FirebaseFirestore.instance.collection('Users');
  
  // Signup method. Create new document inside the collection
  Future<DocumentReference> signUp(UserModel userModel) async {

    //create a new document(record)
    final newDocRef = collection.doc();

    //put the record id in usermodel
    Map userMap = userModel.toJson();
    userMap['id'] = newDocRef.id;

    //save the record
    await newDocRef.set(userMap);

    return newDocRef;
  }

  // Login method. Fetch a document with given email & password from the collection
  Future<UserModel> login(String email, String password) async {
    //query
    final querySnapShot = await collection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get()
        .catchError(
      (error) {
        print(error);
        //TODO: Throw Exception
      },
    );
    if (querySnapShot.docs.length > 0) {
      return UserModel.fromMap(querySnapShot.docs.first.data());
    } else {
      //TODO: Throw Exception
    }
    return null;
  }

  // Update method.
  updateUser(UserModel user) async {
    //get the document(record) with userId and update it
    await collection.doc(user.id).update(user.toJson()).catchError(
      (error) {
        //TODO: Throw Exception
      },
    );
  }
  // Fetch user with unique id
  Future<UserModel> getUserById(String id) async {
    final docSnapshot = await collection.doc(id).get();

    if (docSnapshot.exists) {
      final user = UserModel.fromMap(docSnapshot.data());
      return user;
    } else {
      //TODO: Throw Exception
      return null;
    }
  }

  // Delete user
  Future<void> deleteUserById(String id) async {
    //get the document(record) with userId and delete it
    await collection.doc(id).delete();
  }
}
