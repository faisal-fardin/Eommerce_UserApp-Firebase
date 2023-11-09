
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user_app/models/app_user.dart';

class DBbHelper{

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionCategory = 'category';
  static const String collectionProduct = 'Product';
  static const String collectionUsers = 'Users';

  static Future<void> addUser(AppUser user){
    return _db.collection(collectionUsers)
        .doc(user.id)
        .set(user.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategory() =>
      _db.collection(collectionCategory)
      .orderBy('name')
      .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProduct() =>
      _db.collection(collectionProduct).where('available', isEqualTo: true) .snapshots();

}


