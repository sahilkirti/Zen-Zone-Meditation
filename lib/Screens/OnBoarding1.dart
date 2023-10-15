import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarding extends StatefulWidget {

  onBoarding({Key? key}) : super(key: key);

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  final _controller = LiquidController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            enableLoop: false,
            liquidController: _controller,
            fullTransitionValue: 300,
            waveType: WaveType.circularReveal,
            onPageChangeCallback: (value){
              setState(() {
                currentPage = value;
              });
            },
              slideIconWidget: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              enableSideReveal: true,
              pages: [
                OnBoardingPage(
                  height: 0.5,
                  bgcolor: Color(0xffd7cdff),
                  counter: '1/3',
                  image:
                      'https://assets5.lottiefiles.com/packages/lf20_kvwtrk4n.json',
                  size: MediaQuery.of(context).size,
                  title: 'Meditate the World \n    With Zen Zone',
                  subtitle:
                      'Lets start our journey with us on this amazing platform',
                ),
                OnBoardingPage(
                    size: MediaQuery.of(context).size,
                    subtitle:
                        'Meditation, a path to the inner world,\nA quest for self-discovery.',
                    counter: '2/3',
                    bgcolor: Color(0xffc7e1f5),
                    image:
                        'https://assets10.lottiefiles.com/packages/lf20_w8a6i9im.json',
                    title: 'Dive deeper into tranquility',
                    height: 0.5),
                OnBoardingPage(
                    size: MediaQuery.of(context).size,
                    subtitle:
                        'Meditation is the journey of a lifetime \nnot a spirit to instant Progress',
                    counter: '3/3',
                    bgcolor: Color(0xfff1d8ca),
                    image:
                        'https://assets9.lottiefiles.com/packages/lf20_xpjgkwmf.json',
                    title: 'Get Started \n with Zen-Zone',
                    height: 0.5),
              ],
          ),

          currentPage == 2 ? Positioned(
            bottom: 60,
            child: Container(
              child: OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(15),
                    ),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                          width: 2,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                  ),
                  onPressed: ()
                  {
                    Navigator.pushReplacementNamed(context, '/Welcome_screen');
                  },
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  )),
            ),
          ) :Positioned(
            bottom: 60,
            child: OutlinedButton(
              onPressed: () {
               _controller.animateToPage(page: currentPage+1);
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black ,width: 20),
                  shape: const CircleBorder() ,
                  padding: const EdgeInsets.all(20)),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.056,
            child: AnimatedSmoothIndicator(
              activeIndex: _controller.currentPage,
              count: 3,
              effect: const WormEffect(
                activeDotColor: Colors.black,
                dotHeight: 5,
                dotWidth: 120,
                strokeWidth: 6,
              ),
            ),
          )
        ],
      ),
    );
  }

onPageChangeCallBack(int activePageIndex) {
    currentPage = activePageIndex;
}
}

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String counter;
  final Color bgcolor;
  final double height;
  final String image;

  const OnBoardingPage({
    super.key,
    required this.size,
    required this.subtitle,
    required this.counter,
    required this.bgcolor,
    required this.title,
    required this.height,
    required this.image,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: bgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Lottie.network(image, height: size.height * height),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black),
              ),
              Text(
                textAlign: TextAlign.center,
                subtitle,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ],
          ),
          Text(
            textAlign: TextAlign.center,
            counter,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.black),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
