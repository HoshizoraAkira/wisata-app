import 'package:flutter/material.dart';
import 'package:wisata_app/common/constants.dart';
import 'package:wisata_app/screens/login_screen.dart';
import 'package:wisata_app/common/size_config.dart';
import 'package:wisata_app/widgets/default_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  final PageController _pageController = PageController();
  final Duration _animationDuration = const Duration(milliseconds: 500);

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Wisata App, Let’s Vacation!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help people conect with store \naround Indonesia",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to vacation. \nJust connect with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _animateSplashScreen();
  }

  void _animateSplashScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (currentPage < splashData.length - 1) {
        _pageController.animateToPage(
          currentPage + 1,
          duration: _animationDuration,
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: _animationDuration,
          curve: Curves.easeInOut,
        );
      }
      _animateSplashScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
        child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController, // Add PageController
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    const Spacer(),
                    const Text(
                      "Wisata App",
                      style: TextStyle(
                        fontSize: 36,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      splashData[index]['text']!,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(flex: 2),
                    Image.asset(
                      splashData[index]["image"]!,
                      height: getProportionateScreenHeight(265),
                      width: getProportionateScreenWidth(235),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.only(
                              right: getProportionateScreenWidth(5)),
                          height: getProportionateScreenHeight(6),
                          width: currentPage == index ? 20 : 6,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? primaryColor
                                : bgLightColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }),
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
