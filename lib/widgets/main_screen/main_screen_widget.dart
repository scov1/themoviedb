import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/inherited/provider.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

  int _selectedTab = 1;
  final movieListModel = MovieListModel();

  void onSelectTab(int index){
    if(_selectedTab==index)return;
    setState(() {
      _selectedTab=index;
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocale(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
        actions: [
          IconButton(icon: const Icon(Icons.exit_to_app), onPressed: (){
            SessionDataProvider().setSessionId(null);
          })
        ],
      ),
    
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _selectedTab, 
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie),label: 'Films'),
          BottomNavigationBarItem(icon: Icon(Icons.tv),label: 'Serials'),
        ],
        onTap: onSelectTab,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Text('Home'),
          NotifierProvider(model: movieListModel, child: MovieListWidget()),
          Text('Serials'),
        ],
      )
    );
  }
}