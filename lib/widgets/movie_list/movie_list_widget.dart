import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/Library/Widgets/inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';


class MovieListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieListModel>(context);
    if(model == null){
      return SizedBox.shrink();
    }
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top:70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context,int index){
            model.showMovieAtIndex(index);
            final movie = model.movies[index];
            final posterPath = movie.posterPath;
            final releaseDate = movie.releaseDate;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0,vertical:10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration( 
                      color: Colors.white, 
                      border: Border.all(color:Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius:8,
                          offset:Offset(0,2),
                        )
                      ]
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        posterPath != null ? Image.network(ApiClient.imageUrl(posterPath),width: 95,): SizedBox.shrink(),
                        SizedBox(width:15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:20),
                              Text(movie.title,style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                              SizedBox(height:5),
                              Text(
                                model.stringFromDate(movie.releaseDate),
                                style: TextStyle(color: Colors.grey),maxLines: 1,
                                ),
                              SizedBox(height:20),
                              Text(movie.overview,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                        SizedBox(width:10)
                      ],
                     ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell( 
                      borderRadius: BorderRadius.circular(10),
                      onTap: ()=>{
                        model.onMovieTap(context, index)
                      },
                    ),
                  )
                ],
              ),
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: model.searchMovie,
            decoration: InputDecoration(  
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder()
            ),
          ),
        )
      ],
    );
  }
}



  // void _searchMoview(){
  //   if(_searchController.text.isNotEmpty){
  //     _filterMovies = _movies.where((Movie movie){
  //       return movie.title.toUpperCase().contains(_searchController.text.toUpperCase());
  //     }).toList();
  //   }else{
  //     _filterMovies = _movies;
  //   }
  //   setState(() {
      
  //   });
  // }


