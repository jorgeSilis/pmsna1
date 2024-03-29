import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPassController = TextEditingController();
  File? _image;
  final _formRegister = GlobalKey<FormState>();
  EmailAuthClass? emailAuth;

  final CircleAvatar _circleAvatar = CircleAvatar(
    backgroundImage:
        NetworkImage("https://cdn-icons-png.flaticon.com/512/9780/9780028.png"),
    radius: 80,
  );

  late final txtName = TextFormField(
    controller: txtNameController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("Full name"), border: OutlineInputBorder()),
  );

  late final txtEmail = TextFormField(
    controller: txtEmailController,
    validator: (value) {
      if (value == null ||
          value.isEmpty ||
          EmailValidator.validate(value) == false) {
        return 'Please verify your email';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("EMAIL USER"), border: OutlineInputBorder()),
  );

  late final txtPass = TextFormField(
    controller: txtPassController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter password';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("Password"), border: OutlineInputBorder()),
  );

  final horizontalSpace = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    final buttonRegister = TextButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 73, 132)),
      ),
      onPressed: () {
        if (_formRegister.currentState!.validate()) {
          print("Kek");
          _image != null
              ? emailAuth?.createUserWithEmailAndPassword(
                  email: txtEmailController.text,
                  password: txtPassController.text,
                  name: txtNameController.text,
                  photo: _image?.path)
              : emailAuth?.createUserWithEmailAndPassword(
                  email: txtEmailController.text,
                  password: txtPassController.text,
                  name: txtNameController.text);

          print("Kek2");
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Usuario registrado')));
        }
        print("final kek");
        Navigator.pop(context);
      },
      child: Text('Become part of us!'),
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
                  Form(
                      key: _formRegister,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Elige una opción"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("Galería"),
                                        onPressed: () async {
                                          final picker = ImagePicker();
                                          final pickedFile =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (pickedFile != null) {
                                            setState(() {
                                              _image = File(pickedFile.path);
                                            });
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Cámara"),
                                        onPressed: () async {
                                          final picker = ImagePicker();
                                          final pickedFile =
                                              await picker.pickImage(
                                                  source: ImageSource.camera);
                                          if (pickedFile != null) {
                                            setState(() {
                                              _image = File(pickedFile.path);
                                            });
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : _circleAvatar.backgroundImage
                                      as ImageProvider,
                              radius: 80,
                            ),
                          ),
                          horizontalSpace,
                          txtName,
                          horizontalSpace,
                          txtEmail,
                          horizontalSpace,
                          txtPass,
                          horizontalSpace,
                          buttonRegister
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
