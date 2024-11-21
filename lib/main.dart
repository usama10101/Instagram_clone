import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/cubit/post/post_cubit.dart';
import 'package:instagram/view/home_page.dart';
import 'package:instagram/view/login_page.dart';
import 'package:instagram/view/splash_page.dart';
import 'package:sizer/sizer.dart';
import 'package:instagram/cubit/auth/auth_cubit.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/shared/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
              create: (context) => PostCubit(),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
