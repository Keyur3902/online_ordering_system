import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocProject/cubit/Cart/cubit/cart_cubit.dart';
import 'package:online_ordering_system/BlocProject/cubit/ProductList/cubit/product_list_cubit.dart';
import 'constants/routes.dart';
import 'cubit/Favourites/cubit/favourite_cubit.dart';

class BlocApp extends StatefulWidget {
  const BlocApp({Key? key}) : super(key: key);

  @override
  State<BlocApp> createState() => _BlocAppState();
}

class _BlocAppState extends State<BlocApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ProductListCubit()),
        BlocProvider(create: (context) => FavouriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: Routes.loginPageBloc,
      ),
    );
  }
}
