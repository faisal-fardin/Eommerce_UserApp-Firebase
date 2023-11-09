
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';
import '../models/category_models.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier{

  List<CategoryModels> categoryList = [];
  List<ProductModel> productList = [];


  getAllCategories(){
    DBbHelper.getAllCategory().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length, (index) =>
          CategoryModels.fromJson(snapshot.docs[index].data()
          ));
      notifyListeners();
    });
  }

  getAllProducts(){
    DBbHelper.getAllProduct().listen((snapshot) {
      productList = List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromJson(snapshot.docs[index].data()
          ));
      notifyListeners();
    });
  }


  ProductModel getProductByid(String id){
    return productList.firstWhere((element) => element.id == id);
  }

  Future<void> updateProductField(String id, String field, dynamic value) async {

  }

  num priceAfterDiscount(num price , int discount){
    return price - (price * discount ~/ 100);
  }

  Future<String> uploadImage(String path) async{
    final imageName= 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref()
        .child('Picture/$imageName');
    final uploadTask = photoRef.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);

    return snapshot.ref.getDownloadURL();

  }

}