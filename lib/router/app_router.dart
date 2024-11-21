import 'package:flutter/material.dart';
import 'package:instagram/router/routes.dart';
import 'package:instagram/view/choose_image.dart';
import 'package:instagram/view/home_page.dart';
import 'package:instagram/view/login_page.dart';
import 'package:instagram/view/signup_page.dart';
import 'package:instagram/view/splash_page.dart';


Route? onGenerateRouter(RouteSettings settings) {
  switch (settings.name) {
    case AppRoute.splashScreen:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case AppRoute.loginScreen:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case AppRoute.registerScreen:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case AppRoute.homeScreen:
      return MaterialPageRoute(builder: (_) => HomePage());
    case AppRoute.chooseImage:
      return MaterialPageRoute(builder: (_) => ChooseImage());
    default:
      return null;
  }

  // late Widget startScreen;
  //  Route? onGenerateRouter(RouteSettings settings){
  //    startScreen = const SplashScreen();
  //    switch(settings.name){
  //      case '/':
  //        return MaterialPageRoute(builder: (_)=> startScreen);
  //      case screens.homeScreen:
  //        return MaterialPageRoute(builder: (_)=> const HomeScreen());
  //      default:
  //        return null ;
  //    }
  //  }
}
