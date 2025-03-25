import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'blocs/product_bloc.dart';
import 'blocs/product_event.dart';
import 'screens/product_list.dart';
import 'screens/cart_screens.dart';
import 'services/cart_service.dart';
import 'services/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductService())..add(FetchProducts()),
        ),
        BlocProvider(
          create: (context) => CartBloc(CartService()),
        ),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ProductListScreen(),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
