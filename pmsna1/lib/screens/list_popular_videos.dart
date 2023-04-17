import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';
import 'package:flutter_application_1/widgets/item_popular.dart';
import 'package:provider/provider.dart';
import '../provider/flags_provider.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({super.key});

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPopular;
  bool only_favs = false;
  DatabaseHelper? database;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas Populares'),
        actions: [
          IconButton(
              onPressed: () {
                only_favs = only_favs ? false : true;
                setState(() {});
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: FutureBuilder(
          future: flag.getFlag_movieList() == true
              ? apiPopular!.getAllPopular()
              : apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  return ItemPopular(
                    model: snapshot.data![index],
                    show: only_favs,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocurrio un error'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
