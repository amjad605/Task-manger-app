import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/DataBaseHelper/DBHelper.dart';
import 'package:untitled3/Layout/Home_layout.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final int numpages = 3;
  final controller = PageController(initialPage: 0);
  int currpage = 0;
  List<Widget> _builddIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numpages; i++) {
      list.add(i == currpage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.circular(20)),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.1,
              0.4,
              0.7,
              0.9
            ],
                colors: [
              Color(0xff8501d3),
              Color(0xff51017c),
              Color(0xff360055),
              Color(0xff22013a),
            ])),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/');
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: 550,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (page) {
                    currpage = page;
                    setState(() {});
                  },
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image(
                            image: AssetImage(
                              "assets/images/Manger.png",
                            ),
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Manage Your Tasks",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Organize all your to-do's in lists and \n projects.Color tag them to set\n priorities and categories.",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: const Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Image(
                              image: AssetImage(
                                "assets/images/5649971.png",
                              ),
                              width: 300,
                              height: 300,
                            )),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Get your task done",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "When you're overwhelmed by the amount \n of work you have on your plate, \n stop and rethink. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: const Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Image(
                              image: AssetImage(
                                "assets/images/Org.png",
                              ),
                              width: 300,
                              height: 300,
                            )),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Organize your tasks",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "When you encounter a small task that takes\n less than 5 minutes to complete,\n just get it done.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _builddIndicator(),
              ),
              const SizedBox(
                height: 35,
              ),
              currpage != numpages - 1
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                border: Border.fromBorderSide(
                                    BorderSide(color: Colors.white)),
                                color: Colors.transparent),
                            child: TextButton(
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              ),
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        padding: EdgeInsetsDirectional.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeLayout()));
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              child: Container(
                                  width: 300,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: const Text('Get Started')),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      // bottomSheet: currpage == numpages - 1
      //     ? Container(
      //         height: 100,
      //         color: Colors.white,
      //         width: double.infinity,
      //         child: Center(
      //           child: GestureDetector(
      //               onTap: () {
      //                 HapticFeedback.mediumImpact();
      //                 Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                     builder: (context) => HomeLayout()));
      //                 Navigator.pop(context);
      //               },
      //               child: Padding(
      //                 padding: EdgeInsets.only(
      //                   bottom: 30,
      //                 ),
      //                 child: Text(
      //                   "Get Started",
      //                   style: TextStyle(
      //                       color: Colors.deepPurpleAccent.shade700,
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.bold),
      //                 ),
      //               )),
      //         ))
      //     : Text(''),
    );
  }
}
