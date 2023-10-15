import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  final controller = PageController();

  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8D8CF7),
      body: PageView(
        controller: controller,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 30, top: 100),
                //color: Color(0xFF4542b5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_kvwtrk4n.json'),
                    SizedBox(
                      height: 103,
                    ),
                    Text(
                      'Meditate the World \n    With Zen Zone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 110,
                    ),
                    Row(
                      children: [
                        TextButton(
                          child: Text(
                            'SKIP',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            controller.jumpToPage(3);
                          },
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 4,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        TextButton(
                          child: Text(
                            'NEXT',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          onPressed: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInCirc),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 100),
            //color: Color(0xFF4542b5),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_w8a6i9im.json'),
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Dive deeper into tranquility',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                    child: Text(
                      'Meditation, a path to the inner world, \n        A quest for self-discovery, \n       An invitation to go beyond, \n           The chaos and hurry.',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )),
                SizedBox(
                  height: 140,
                ),
                Row(
                  children: [
                    TextButton(
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCirc),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 100),
            //color: Color(0xFF4542b5),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Lottie.network(
                    'https://assets1.lottiefiles.com/private_files/lf30_7iqz36ms.json'),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'No Delivery Charges on orders \n              above Rs 149/-',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 190,
                ),
                Row(
                  children: [
                    TextButton(
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCirc),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 30, top: 100),
              //color: Color(0xFF4542b5),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_jTlqMXSVEM.json'),
                  SizedBox(
                    height: 100,
                  ),
                  OutlinedButton(
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
                  SizedBox(
                    height: 190,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}