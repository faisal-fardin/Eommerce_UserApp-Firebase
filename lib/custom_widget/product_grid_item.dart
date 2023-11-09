import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_user_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              fadeInDuration: const Duration(seconds: 2),
              fadeInCurve: Curves.bounceInOut,
              imageUrl: product.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
           Padding(padding: const EdgeInsets.all(20),
            child: Text(product.name, overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }
}
