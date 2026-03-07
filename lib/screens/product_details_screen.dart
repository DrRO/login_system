import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products/cubit.dart';
import '../cubit/products/states.dart';


class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  void initState() {
    super.initState();
    ProductDetailsCubit.get(context).getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {

        var cubit = ProductDetailsCubit.get(context);
        var product = cubit.product;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Product Details"),
          ),

          body: state is ProductDetailsLoading
              ? const Center(child: CircularProgressIndicator())
              : product == null
              ? const Center(child: Text("No Data"))
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Product Image
                Image.network(
                  product.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image, size: 100),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Title
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Category
                      Text(
                        "Category: ${product.category}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Price
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 40),



                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}