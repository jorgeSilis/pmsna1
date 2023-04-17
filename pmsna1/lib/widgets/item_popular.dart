import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../provider/flags_provider.dart';
import '../screens/video_details_screen.dart';

class ItemPopular extends StatefulWidget {
  const ItemPopular({super.key, required this.model, required this.show});

  final PopularModel model;
  final bool show;

  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  DatabaseHelper? database;
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = DatabaseHelper();
    update_isFav(widget.model.id);
  }

  void update_isFav(id) async {
    isFav = await database!.MARC_FAV(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  FlagsProvider flag = Provider.of<FlagsProvider>(context);
  if (!widget.show || (widget.show && isFav)) {
    return Center(
      child: Stack(
        children: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoDetailsScreen(
                        movie: widget.model,
                      ),
                    )).then((value) => {
                      flag.setFlag_movieList(),
                      setState(() {
                        update_isFav(widget.model.id!);
                        flag.setFlag_movieList();
                      }),
                    });
              },
              child: Hero(
                tag: 'video_${widget.model.id}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(5, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${widget.model.posterPath}'),
                    ),
                  ),
                ),
              )),
          isFav
              ? IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    database?.BORRAR_FAV(widget.model.id!).then((value) {
                      var msg = value > 0 ? 'Removida de favoritos' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlag_movieList();
                      update_isFav(widget.model.id!);
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ))
              : IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    database?.INSERT('tblFavorites',
                        {'idMovie': widget.model.id}).then((value) {
                      var msg = value > 0 ? 'Agregada a favoritos' : 'Error';
                      var snackBar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flag.setFlag_movieList();
                      update_isFav(widget.model.id!);
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ))
        ],
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

}