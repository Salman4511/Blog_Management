import 'package:blog_management_app/controller/auth_controller.dart';
import 'package:blog_management_app/controller/blog_controller.dart';
import 'package:blog_management_app/view/auth/login_screen.dart';
import 'package:blog_management_app/view/auth/signup_screen.dart';
import 'package:blog_management_app/view/auth/widget_tree.dart';
import 'package:blog_management_app/view/home/blog_list_screen.dart';
import 'package:blog_management_app/view/home/create_post_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCIU419r1wZ16AOCHH5bFs-bAdgZ8uc-9U',
      appId: '1:177657642411:android:90b9629b36ac44f00726ee',
      messagingSenderId: '177657642411',
      projectId:'blog-management-b909a',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => BlogController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog Management App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Consumer<AuthController>(
          builder: (ctx, auth, _) {
            return const Authpage();
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => BlogListScreen(),
          '/createPost': (context) => const CreatePostScreen(),
        },
      ),
    );
  }
}
