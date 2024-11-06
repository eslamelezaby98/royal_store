import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:royal_store/core/connection/network_info.dart';
import 'package:royal_store/core/routes/app_routes.dart';
import 'package:royal_store/core/routes/generate_routes.dart';
import 'package:royal_store/views/auth/data/repo/auth_repo.dart';
import 'package:royal_store/views/auth/presentation/controller/auth_controller.dart';
import 'package:royal_store/views/cart/data/repo/cart_repo.dart';
import 'package:royal_store/views/cart/presentation/controller/cart_controller.dart';
import 'package:royal_store/views/product/data/repo/product_repo.dart';
import 'package:royal_store/views/product/presentation/controller/product_controller.dart';
import 'core/databases/api/dio_consumer.dart';
import 'core/databases/cache/cache_helper.dart';
import 'views/product/data/sources/local_products.dart';
import 'views/product/data/sources/remote_product.dart';
import 'views/product/data/sources/search_products.dart';

User? currentUser() {
  return FirebaseAuth.instance.currentUser;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductController(
            productRepo: ProductRepoImp(
              networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
              remoteProducts:
                  RemoteProducts(apiConsumer: DioConsumer(dio: Dio())),
              localProducts: LocalProducts(cacheHelper: CacheHelper()),
              searchProducts: SearchProduct(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => AuthController(AuthRepoImpl())),
        ChangeNotifierProvider(
          create: (_) => CartController(FirebaseCartRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: currentUser() != null ? AppRoutes.main : AppRoutes.signIn,
        onGenerateRoute: GenerateRoutes().generate,
      ),
    );
  }
}
