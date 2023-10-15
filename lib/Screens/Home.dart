import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Modal/ProductModal/ProductModalAudio.dart';
import 'package:final2/Modal/ProductModal/ProductModelVideoHome.dart';
import 'package:final2/Widgets/Carousal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Chat2/HomePage.dart';
import '../Modal/ProductModal/ProductModalBook1.dart';
// import '../chat/ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  final String documentId;

  const HomeScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> dailyMeditationTips = [
    "Start your day with 5 minutes of deep breathing.",
    "Find a quiet place to meditate.",
    "Sit comfortably with your back straight.",
    "Focus on your breath and observe your thoughts.",
    "Let go of any distractions and bring your attention back to your breath.",
    "Use a guided meditation app or recording.",
    "Experiment with different types of meditation techniques.",
    "Try to meditate at the same time every day.",
    "Set an intention for your meditation practice.",
    "Begin with shorter meditation sessions and gradually increase the time.",
    "Use a mantra or phrase to repeat to yourself during meditation.",
    "Don't judge yourself or your thoughts during meditation.",
    "Allow yourself to be present in the moment.",
    "Take a break during the day to meditate.",
    "Focus on your breath while walking or exercising.",
    "Try to find stillness in your mind.",
    "Remember that meditation is a practice, not a performance.",
    "Be patient with yourself and your progress.",
    "Take time to reflect on your meditation practice.",
    "Celebrate small victories in your meditation journey.",
    "Let go of expectations and just be.",
    "Focus on gratitude and positivity during meditation.",
    "Use meditation to manage stress and anxiety.",
    "Connect with a community of meditators.",
    "Visualize a peaceful and calming place during meditation.",
    "Incorporate mindfulness into your daily routine.",
    "Practice self-compassion and self-love.",
    "Take a few deep breaths before responding to stressful situations.",
    "Focus on your breath while waiting in line or in traffic.",
    "Use a meditation cushion or bench for support.",
    "Listen to calming music or sounds during meditation.",
    "Pay attention to your body and any physical sensations.",
    "Don't force yourself to meditate if you're not in the right mindset.",
    "Incorporate meditation into your bedtime routine.",
    "Focus on your breath while eating or drinking.",
    "Journal about your meditation experience.",
    "Find a meditation buddy or accountability partner.",
    "Create a comfortable and inviting meditation space.",
    "Use essential oils or aromatherapy to enhance your meditation practice.",
    "Take a break from technology and distractions during meditation.",
    "Acknowledge and release any negative thoughts or emotions during meditation.",
    "Focus on the present moment, not the past or future.",
    "Use a guided body scan meditation to relax and release tension.",
    "Practice compassion and forgiveness towards yourself and others.",
    "Remember that meditation is a gift to yourself.",
    "Use meditation to cultivate inner peace and happiness.",
    "Take time to express gratitude for the present moment.",
    "Incorporate yoga or other gentle movements into your meditation practice.",
    "Remember that consistency is key in meditation.",
  ];

  String getRandomQuote() {
    final random = Random();
    final index = random.nextInt(dailyMeditationTips.length);
    return dailyMeditationTips[index];
  }

  @override
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  Widget build(BuildContext context) {
    Future<void> _handleRefresh() async {
      await Future.delayed(Duration(milliseconds: 500));
    }

    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return SafeArea(child: const Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return SafeArea(child: const Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: Colors.white,
              // drawer: NavDrawer(
              //     email: data['email'],
              //     Name: data['name'],
              //     Image: data['profileimage']),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Color(0xffeafddd),
                centerTitle: true,
                leading: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                    child: Icon(Icons.message)),
                title: Text(
                  'FeelBetter',
                  style: GoogleFonts.abyssinicaSil(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(data['profileimage']))),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/Blur/')
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
                  ),
                ),
                child: LiquidPullToRefresh(
                  animSpeedFactor: 20,
                  springAnimationDurationInMilliseconds: 1000,
                  showChildOpacityTransition: false,
                  color: Colors.black,
                  onRefresh: _handleRefresh,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        DestinationCarousal(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .86,
                          height: MediaQuery.of(context).size.height * .13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 1),
                                    spreadRadius: 0.3,
                                    color: Colors.black)
                              ],
                              border: Border.all(color: Colors.black, width: 1)),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .9,
                                height:
                                    MediaQuery.of(context).size.height * .13 / 3,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xffaec2fa),
                                      Color(0xffb6e6c5),
                                    ]),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 1))),
                                child: Center(
                                  child: Text(
                                    'Zen - Zone Tips',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.abyssinicaSil(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .9,
                                  height: MediaQuery.of(context).size.height *
                                      .13 /
                                      1.54,
                                  child: Center(
                                    child: Text(
                                      getRandomQuote(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.abyssinicaSil(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileHeaderLabel(headerLabel: 'Zen-Zone Meditation'),
                        StreamBuilder<QuerySnapshot>(
                          stream: _productStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height *
                                          .37,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(1, 1),
                                                spreadRadius: 0.3,
                                                color: Colors.black)
                                          ],
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'images/Blur/NoResult.jpg')),
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              spreadRadius: 0.3,
                                              color: Colors.black)
                                        ],
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'This category \n has no Meditation items yet !',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.abyssinicaSil(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }

                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(10),
                                  // child: StaggeredGridView.countBuilder(
                                  //     physics: const NeverScrollableScrollPhysics(),
                                  //     shrinkWrap: true,
                                  //     itemCount: snapshot.data!.docs.length,
                                  //     crossAxisCount: 2,
                                  //     itemBuilder: (context, index) {
                                  //       return ProductModelAudio(
                                  //         products: snapshot.data!.docs[index],
                                  //       );
                                  //     },
                                  //     staggeredTileBuilder: (context) =>
                                  //         const StaggeredTile.fit(1)),
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ProductModelAudio(
                                          products: snapshot.data!.docs[index],
                                        );
                                      }),
                                ),
                              ),
                            );
                          },
                        ),
                        BooksHomeView(),
                        SizedBox(height: 5,),
                        VideoScreenView(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
      height: MediaQuery.of(context).size.height / 28,
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .13 / 3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffaec2fa),
                        Color(0xffb6e6c5),
                      ]),
                      border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(
                      headerLabel,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.abyssinicaSil(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class BooksHomeView extends StatefulWidget {
  const BooksHomeView({Key? key}) : super(key: key);

  @override
  State<BooksHomeView> createState() => _BooksHomeViewState();
}

class _BooksHomeViewState extends State<BooksHomeView> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('Book_detail').snapshots();
    return Column(
      children: [
        ProfileHeaderLabel(headerLabel: 'Medito Books'),
        StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .37,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                spreadRadius: 0.3,
                                color: Colors.black)
                          ],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/Blur/NoResult.jpg')),
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              spreadRadius: 0.3,
                              color: Colors.black)
                        ],
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'This category \n has no Meditation Books items yet !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.abyssinicaSil(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3.2,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                // child: StaggeredGridView.countBuilder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: snapshot.data!.docs.length,
                //     crossAxisCount: 2,
                //     itemBuilder: (context, index) {
                //       return ProductModelBook1(
                //         products: snapshot.data!.docs[index],
                //       );
                //     },
                //     staggeredTileBuilder: (context) =>
                //         const StaggeredTile.fit(1)),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductModelBook1(
                          products: snapshot.data!.docs[index]);
                    }),
              ),
            );
          },
        )
      ],
    );
  }
}

class VideoScreenView extends StatefulWidget {
  const VideoScreenView({Key? key}) : super(key: key);

  @override
  _VideoScreenViewState createState() => _VideoScreenViewState();
}

class _VideoScreenViewState extends State<VideoScreenView> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
    FirebaseFirestore.instance.collection('Video_detail').snapshots();
    return Column(
      children: [
        ProfileHeaderLabel(headerLabel: 'Medito Video'),
        SizedBox(height: 5,),
        StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 100, 60, 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .37,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                spreadRadius: 0.3,
                                color: Colors.black)
                          ],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/Blur/NoResult.jpg')),
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              spreadRadius: 0.3,
                              color: Colors.black)
                        ],
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'This category \n has no Meditation Video items yet !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.abyssinicaSil(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                // child: StaggeredGridView.countBuilder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: snapshot.data!.docs.length,
                //     crossAxisCount: 2,
                //     itemBuilder: (context, index) {
                //       return ProductModelBook1(
                //         products: snapshot.data!.docs[index],
                //       );
                //     },
                //     staggeredTileBuilder: (context) =>
                //         const StaggeredTile.fit(1)),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ProductModelVideoHome(
                          products: snapshot.data!.docs[index]);
                    }),
              ),
            );
          },
        )
      ],
    );
  }
}
