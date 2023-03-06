
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Login_screen.dart';
import 'package:lottie/lottie.dart';
import '../widgets/card_planet.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "Forma parte de ITC",
      subtitle:
          "Conoce tu aplicación, conócete a ti lince",
      image: const AssetImage("assets/images/lince-1.png"),
      backgroundColor: const Color.fromRGBO(54, 87, 42, 34),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "Forma parte del TECNM",
      subtitle: "La mejor casa de estudios en celaya",
      image: const AssetImage("assets/images/tecnm-2.png"),
      backgroundColor: Colors.white,
      titleColor: Color.fromARGB(255, 34, 36, 150),
      subtitleColor: const Color.fromRGBO(94, 122, 84, 48),
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "Disfruta de tu APP",
      subtitle: "Todo itc en tu palma, explora y conoce tu app",
      image: const AssetImage("assets/images/itclandscape-3.jpg"),
      backgroundColor: Color.fromARGB(153, 60, 140, 60),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
