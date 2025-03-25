import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_bloc.dart';
import '../blocs/product_event.dart';
import '../blocs/product_state.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../blocs/cart_state.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<ProductBloc>().add(FetchProducts());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildProductTile(Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Image.network(
          product.thumbnail,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '₹ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              '₹ ${product.discountedPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            context.read<CartBloc>().add(AddToCart(product));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} added to cart'),
                duration: const Duration(milliseconds: 800),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: Badge(
                      label: Text('${state.totalQuantity}'),
                      child: const Icon(Icons.shopping_cart),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial ||
              state is ProductLoading && state.props.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;

            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: products.length + (state.hasMore ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                if (index < products.length) {
                  final product = products[index];
                  return ProductCard(
                    imageUrl: product.thumbnail,
                    productName: product.title,
                    brand: product.brand,
                    originalPrice: product.price,
                    discountedPrice: product.discountedPrice,
                    onAddToCart: () {
                      context.read<CartBloc>().add(AddToCart(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} added to cart'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else if (state is ProductError) {
            return Center(
              child: Text('Failed to load products 😢\n${state.message}'),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
