import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;
  final _formRegister = GlobalKey<FormState>();

  final CircleAvatar _circleAvatar = CircleAvatar(
    backgroundImage:
        NetworkImage("https://cdn-icons-png.flaticon.com/512/9780/9780028.png"),
    radius: 80,
  );

  final txtName = TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("Full name"), border: OutlineInputBorder()),
  );

  final txtEmail = TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty || EmailValidator.validate(value)==false) {
        return 'Please verify your email';
      }
      return null;
    },
    decoration: const InputDecoration(
        label: Text("EMAIL USER"), border: OutlineInputBorder()),
  );

  final txtPass = TextFormField(
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
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Datos validados')),
          );
        }
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
