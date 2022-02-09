
import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/inherited/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';

class MainNavigationRouteNames{
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation{

  String initialRoute(bool isAuth)=> isAuth ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.auth;

  final routes = <String,Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(model: AuthModel(),child: AuthWidget(),),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(model: MainScreenModel(),child: MainScreenWidget(),) //MainScreenWidget(), 
  };

  Route<Object> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(builder: (context) => 
          MovieDetailsWidget(movieId: movieId)
        );
        default: 
          const widget = Text('Navigation error!');
          return MaterialPageRoute(builder: (context)=> widget);
    }
  }
}