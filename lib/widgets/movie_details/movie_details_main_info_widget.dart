import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieDetailsMainInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPostersWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:117.0,vertical: 20),
          child: _MovieTitleWidget(),
        ),
        _ScoreWidget(),
        _JanreWidget(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _OverViewWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(height:20),
        _PeopleWidget(),
        
      ],
    );
  }

  Text _DescriptionWidget() => Text('Hundreds of cash-strapped players accept a strange invitation to compete in children`s games—with high stakes. But, a tempting prize awaits the victor.',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white));

  Text _OverViewWidget() => Text('Overview',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white));
}

class _TopPostersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: AssetImage(AppImages.poster),height: 220,width: 500,fit: BoxFit.fill,),
        Positioned(
          top:20,
          left:10,
          bottom: 20,
          child: Image(image: AssetImage(AppImages.movie_4),height: 220,)
        )
      ],
    );
  }
}

class _MovieTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(  
        children: [
          TextSpan(
            text: 'Squid Game',
            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20.85)
          ),
          TextSpan(
            text: ' (2021)',
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16)
          ),
        ]
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: (){}, child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              // child: RadialPercentWidget( 
              //   percent: 0.72,
              //   fillColor: Color.fromARGB(255, 10, 23, 25),
              //   lineColor: Color.fromARGB(255, 37, 203, 103),
              //   freeColor: Color.fromARGB(255, 25, 54, 31),
              //   lineWidth: 3,
              //   child: Text('72'),
              // ),
            ),
            SizedBox(width:10),
            Text('User Score'),
          ],
        )),
        Container( 
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
         TextButton(onPressed: (){}, child: Row(  
           children: [
             Icon(Icons.play_arrow),
             Text('Play Trailer'),
           ],
         )),
      ],
    );
  }
}

// class RadialPercentWidget extends StatelessWidget {

//   final Text child;
//   final double percent;
//   final Color fillColor;
//   final Color lineColor;
//   final Color freeColor;
//   final int lineWidth;
  


//   const RadialPercentWidget({Key key, this.percent, this.fillColor, this.lineColor, this.freeColor, this.lineWidth, this.child}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

class _JanreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:90),
        child: Text(
          'TV-MA, ~ 54m,Action & Adventure,Mystery,Drama',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color:Colors.white)
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final nameStyle = TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color:Colors.white);

    final jobTitleStyle = TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color:Colors.white);

    return Row(  
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hwang Dong-hyuk',style: nameStyle,),
            Text('Creator',style: jobTitleStyle,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hwang Dong-hyuk',style: nameStyle,),
            Text('Director',style: jobTitleStyle,),
          ],
        ),
      ],
    );
  }
}