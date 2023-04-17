import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_images/placeholder_images.dart';

import '../models/popular_model.dart';

class PopularCastItem extends StatelessWidget {
  const PopularCastItem({super.key, required this.model});

  final PopularCast model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          model.profilePath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(45.0),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                      placeholder: (context, url) =>
                          Image.asset('assets/loading.gif'),
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${model.profilePath!}'),
                )
              : CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: NetworkImage(
                      PlaceholderImage.getPlaceholderImageURL(model.name)),
                ),
          Text(
            model.name,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}