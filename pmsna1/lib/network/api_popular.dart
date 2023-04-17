import 'dart:convert';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:http/http.dart' as http;
class ApiPopular{
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=d347bb71853e5b73cc14f36ac111109f&language=es-MX&page=1');
  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if(result.statusCode == 200){
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }


   Future<List<PopularTrailer>?> getTrailer(int movie_id) async {
    try {
      var result = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${movie_id}/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c&language=es-MX'));
      var listJson = jsonDecode(result.body)['results'] as List;
      if (result.statusCode == 200) {
        return listJson
            .map((popular) => PopularTrailer.fromMap(popular))
            .toList();
      }
    } catch (e) {
      print('Oops hubo un error en el trailer');
      return null;
    }
    return null;
   }

   Future<List<PopularCast>?> getCast(int movie_id) async {
    try {
      var result = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${movie_id}/credits?api_key=d7236b730825fb7b3c7e23e7d91e473c&language=es-MX'));
      var listJson = jsonDecode(result.body)['cast'] as List;
      if (result.statusCode == 200) {
        return listJson.map((popular) => PopularCast.fromMap(popular)).toList();
      }
    } catch (e) {
      print('Oops hubo un error al obtener los trailers');
      return null;
    }
    return null;
  }

}