import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'VideoPlayer.dart';

class MovieScreen extends StatefulWidget
{
  final dynamic products;
  const MovieScreen({Key? key, this.products,}): super(key:key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  double fullRatingValue=0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          ...buildBackground(context,widget.products['Thumbnail'][0]),
          buildMovieInformation(context),
          Positioned(
              bottom:MediaQuery.of(context).size.height*0.05,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent.shade200,
                            fixedSize: Size(MediaQuery.of(context).size.width*0.425, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        onPressed: (){},
                        child: RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 15),
                              children: [
                                TextSpan(
                                  text: 'Add to',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w800),

                                ),
                                const TextSpan(
                                    text: ' Watchlist'
                                )
                              ]
                          ),
                        )
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize:Size(MediaQuery.of(context).size.width*0.425, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )

                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>VideoPlayerCustom(products: widget.products,))
                         );
                        },
                        child: RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black,fontWeight: FontWeight.normal),
                              children: [
                                TextSpan(
                                  text: 'Start',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                                ),
                                const TextSpan(
                                    text: ' Watching'
                                )
                              ]
                          ),
                        )
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
  Positioned buildMovieInformation(BuildContext context)
  {
    return   Positioned(
        bottom: MediaQuery.of(context).size.height*0.18,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                widget.products['VideoName'],
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
              ),
              const SizedBox(height: 8),
              // Text ('${widget.movie.duration.inHours}h ${widget.movie.duration.inMinutes}min' ,style:const TextStyle(color:Colors.white ),
              // ),
              const SizedBox(height: 10,),
              RatingBar.builder(
                initialRating: 3.5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                //ignoreGestures: true,
                itemCount: 5,
                itemSize: 21,
                itemPadding: const EdgeInsets.symmetric(horizontal: 3.8),
                unratedColor: Colors.white,
                itemBuilder: (context,index){
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (ratingValue){
                  setState(() {
                    fullRatingValue=ratingValue;
                  });
                },
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height/6,
                    child: Text(widget.products['Prodesc'],
                      maxLines: 12,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.75,color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  List<Widget> buildBackground(context,dynamic product){
    return [
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        // color:const Color(0xFF000B49),
        color: Colors.white,
      ),
      Image.network(
        widget.products['Thumbnail'][0],
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.36,
        fit: BoxFit.cover,
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.24,0.3]
            ),
          ),
        ),
      ),
    ];
  }
}
