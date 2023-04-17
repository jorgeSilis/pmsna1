import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../database/database_helper.dart';
import '../network/api_popular.dart';
import '../provider/flags_provider.dart';
import '../widgets/item_popular_cast.dart';

class VideoDetailsScreen extends StatefulWidget {
  VideoDetailsScreen({super.key, required this.movie});

  PopularModel movie;

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  DatabaseHelper? database;
  YoutubePlayerController? _controller;
  //late Popular movie;
  ApiPopular? apiPopular;
  List<PopularTrailer>? results;
  List<PopularCast>? aux;
  late PopularTrailer video;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    database = DatabaseHelper();
    select_video(widget.movie.id!);
    update_isFav(widget.movie.id!);
  }

  // ignore: non_constant_identifier_names
  Future select_video(int id) async {
    results = await apiPopular?.getTrailer(id);
    if (results != null) {
      for (var element in results!) {
        if (element.type == 'Trailer' && element.site == 'YouTube') {
          _controller = YoutubePlayerController(
            initialVideoId: element.key,
            flags: const YoutubePlayerFlags(
                autoPlay: true, mute: true, loop: true),
          );
          return;
        }
      }
    } else {
      return null;
    }
  }

  Future<List<PopularCast>?> getCast(int id) async {
    aux = await apiPopular?.getCast(id);
    return aux;
  }

  // ignore: non_constant_identifier_names
  void update_isFav(id) async {
    isFav = (await database?.MARC_FAV(id))!;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(70,0,0,0)),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}',
                          ),
                          height: 300,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        widget.movie.title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.movie.overview!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Calificación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: widget.movie.voteAverage! / 2,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  itemCount: 5,
                  itemSize: 50.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  '${widget.movie.voteAverage!}',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Trailer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            FutureBuilder(
              future: select_video(widget.movie.id!),
              builder: (context, snapshot) {
                if (_controller != null) {
                  return YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  );
                } else {
                  return Container();
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Reparto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 1),
              height:150,
              child: FutureBuilder(
                  future: getCast(widget.movie.id!),
                  builder:
                      (context, AsyncSnapshot<List<PopularCast>?> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            snapshot.data != null ? snapshot.data!.length : 0,
                        itemBuilder: (context, index) {
                          return //null;
                              PopularCastItem(model: snapshot.data![index]);
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
            ),
            isFav
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(255, 108, 124, 211))),
                        onPressed: () {
                          database?.BORRAR_FAV(widget.movie.id!).then((value) {
                            var msg =
                                value > 0 ? 'Removida de favoritos' : 'Error';
                            var snackBar = SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            flag.setFlag_movieList();
                            update_isFav(widget.movie.id!);
                          });
                        },
                        child: const Text('Remover de favoritos')),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 50, bottom: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(255, 108, 124, 211))),
                        onPressed: () {
                          database?.INSERT('tblFavorites',
                              {'idMovie': widget.movie.id}).then((value) {
                            var msg =
                                value > 0 ? 'Agregada a favoritos' : 'Error';
                            var snackBar = SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            flag.setFlag_movieList();
                            update_isFav(widget.movie.id!);
                          });
                        },
                        child: const Text('Agregar a favoritos')),
                  ),
          ],
        ),
      ],
    ));
  }
}
