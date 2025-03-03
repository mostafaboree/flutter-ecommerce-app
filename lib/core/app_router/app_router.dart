import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/modal/product/product.dart';
import 'package:weather_app/data/remote/api_service.dart';
import 'package:weather_app/data/remote/dio_factory.dart';
import 'package:weather_app/data/repo.dart';
import 'package:weather_app/presentetion/Auth/login/login_cubit.dart';
import 'package:weather_app/presentetion/cart/cart_cubit,dart.dart';
import 'package:weather_app/presentetion/cart/cart_screen.dart';
import 'package:weather_app/presentetion/logic/cubit/product_cubit.dart';
import 'package:weather_app/presentetion/on_boarding_screen/onBoarding_screen.dart';
import 'package:weather_app/presentetion/product/screens/home_screen.dart';
import 'package:weather_app/presentetion/product/screens/product_detalis_screen.dart';

import '../../presentetion/Auth/login/login_screen.dart';
import '../../presentetion/Auth/registration/registration_cubit.dart';
import '../../presentetion/Auth/registration/registration_screen.dart';

class AppRouter {
  late DioFactory dioFactory;
  late Repo productRepository;
  late ProductCubit productCubit;
  late LoginCubit loginCubit;
  late RegistrationCubit registrationCubit;
  late CartCubit cartCubit;

  static const  homeRout = '/' ;
  static const   detailsRout='/details' ;
  static const   loginRout='/login' ;
  static const   registerRout='/register' ;
  static const   cartRout='/cart' ;
  static const   profileRout='/profile' ;
  static const   checkoutRout='/checkout' ;
  static const   orderRout='/order' ;
  static const   orderDetailsRout='/orderDetails' ;
  static const   onBoardingRoute='/onBoarding' ;



  AppRouter() {
    dioFactory = DioFactory();
    productRepository = Repo(ApiService(dioFactory.dio));
    productCubit = ProductCubit(productRepository);
    loginCubit = LoginCubit(productRepository);
    registrationCubit = RegistrationCubit(productRepository);
    cartCubit = CartCubit(productRepository);

  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(value: productCubit,
          child:HomeScreen())
        );
      case detailsRout:
        final  product = settings.arguments as ProductModel ;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );
        case loginRout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(value: loginCubit,
          child:LoginScreen())
        );
        case registerRout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(value: registrationCubit,
          child:RegistrationScreen())
        );
        case onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(value: registrationCubit,
          child:OnboardingScreen())
        );
        case cartRout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(value: cartCubit,
          child:CartScreen())
        );
      default:
        return null;    

        
              
        

     
    }
  } 
}