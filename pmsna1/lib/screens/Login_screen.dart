import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive.dart';
import 'package:flutter_application_1/screens/events_screen.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
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
        Future.delayed(Duration(milliseconds: 4000)).then((value) {
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      },
    );

    return Scaffold(
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            heroTag: "settings",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            child: Icon(Icons.settings),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "events",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen(),));
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .5,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/itc_esc.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            //safe area, creamos nuestra vista para web
            child: SafeArea(
              child: Responsive(
                mobile: MobileWelcomeScreen(
                    txtEmail: txtEmail,
                    horizontalSpace: horizontalSpace,
                    txtPass: txtPass,
                    buttonlogging: buttonlogging,
                    googlebtn: googlebtn,
                    btnGithub: btnGithub,
                    txtRegister: txtRegister,
                    imgLogo: imgLogo),
                desktop: Row(
                  children: [
                    Expanded(child: imgLogo),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonsLoginRegister(
                              txtEmail: txtEmail,
                              horizontalSpace: horizontalSpace,
                              txtPass: txtPass,
                              buttonlogging: buttonlogging,
                              googlebtn: googlebtn,
                              btnGithub: btnGithub,
                              txtRegister: txtRegister),
                        ],
                      ),
                    )
                  ],
                ),
                tablet: Center(
                  child: Row(
                    children: [
                      Expanded(child: imgLogo),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                                width: 350,
                                child: SingleChildScrollView(
                                    child: ButtonsLoginRegister(
                                        txtEmail: txtEmail,
                                        horizontalSpace: horizontalSpace,
                                        txtPass: txtPass,
                                        buttonlogging: buttonlogging,
                                        googlebtn: googlebtn,
                                        btnGithub: btnGithub,
                                        txtRegister: txtRegister))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    super.key,
    required this.txtEmail,
    required this.horizontalSpace,
    required this.txtPass,
    required this.buttonlogging,
    required this.googlebtn,
    required this.btnGithub,
    required this.txtRegister,
    required this.imgLogo,
  });

  final TextFormField txtEmail;
  final SizedBox horizontalSpace;
  final TextFormField txtPass;
  final SocialLoginButton buttonlogging;
  final SocialLoginButton googlebtn;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;
  final Image imgLogo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonsLoginRegister(
                txtEmail: txtEmail,
                horizontalSpace: horizontalSpace,
                txtPass: txtPass,
                buttonlogging: buttonlogging,
                googlebtn: googlebtn,
                btnGithub: btnGithub,
                txtRegister: txtRegister),
          ],
        ),
        Positioned(
          top: 85,
          child: imgLogo,
        )
      ],
    );
  }
}

class ButtonsLoginRegister extends StatelessWidget {
  const ButtonsLoginRegister({
    super.key,
    required this.txtEmail,
    required this.horizontalSpace,
    required this.txtPass,
    required this.buttonlogging,
    required this.googlebtn,
    required this.btnGithub,
    required this.txtRegister,
  });

  final TextFormField txtEmail;
  final SizedBox horizontalSpace;
  final TextFormField txtPass;
  final SocialLoginButton buttonlogging;
  final SocialLoginButton googlebtn;
  final SocialLoginButton btnGithub;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
