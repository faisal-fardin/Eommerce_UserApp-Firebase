import 'package:ecom_user_app/pages/launcher_screen.dart';
import 'package:ecom_user_app/pages/logIn_screen.dart';
import 'package:ecom_user_app/pages/product_list_page.dart';
import 'package:ecom_user_app/providers/user_prodiver.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherScreen.routeName,
      routes: {
        LauncherScreen.routeName : (_) => const LauncherScreen(),
        LogInScreen.routeName : (_) => const LogInScreen(),
        ProductListPage.routeName : (_) => const ProductListPage(),

      },
    );
  }
}

