import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/favorites_firebase.dart';

class ListFavoritesCloud extends StatefulWidget {
  const ListFavoritesCloud({super.key});

  @override
  State<ListFavoritesCloud> createState() => _ListFavoritesCloud();
}

class _ListFavoritesCloud extends State<ListFavoritesCloud> {

  FavoritesFirebase _firebase = FavoritesFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firebase.getAllFavorites(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data!.docs[index].get('title')); 
              },
            );
          }else if(snapshot.hasError){
            return const Center(child: Text('Error en la peticion'),);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}