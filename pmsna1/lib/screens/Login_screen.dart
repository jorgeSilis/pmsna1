import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        label: Text("EMAIL USER"), border: OutlineInputBorder()),
  );

  final txtPass = TextFormField(
    decoration: const InputDecoration(
        label: Text("Password"), border: OutlineInputBorder()),
  );

  final horizontalSpace = const SizedBox(
    height: 10,
  );

  
  final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.twitter,
    onPressed: () {},
  );
  final btnGithub = SocialLoginButton(
    buttonType: SocialLoginButtonType.github,
    onPressed: () {},
  );

  final imgLogo = Image.asset(
    'assets/logo_itc.png',
    height: 250,
  );

  @override
  Widget build(BuildContext context) {
    final txtRegister = Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text(
          "Crear cuenta",
          style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
        ),
      ),
    );

    final buttonlogging = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 4000)).then((value){
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
        });
        
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .5,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/itc_esc.jpg'))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      txtEmail,
                      horizontalSpace,
                      txtPass,
                      horizontalSpace,
                      buttonlogging,
                      horizontalSpace,
                      googlebtn,
                      horizontalSpace,
                      btnGithub,
                      txtRegister
                    ],
                  ),
                  Positioned(
                    top: 100,
                    child: imgLogo,
                  )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}
