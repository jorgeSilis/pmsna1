
import 'package:flutter/material.dart';

class LoadingModalWidget extends StatelessWidget {
  const LoadingModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color.fromARGB(99, 151, 151, 151),
      child: Center(child: Image.asset('assets/loading.gif')),
    );
  }
}