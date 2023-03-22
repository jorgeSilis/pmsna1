import 'dart:convert';

import 'package:flutter_application_1/models/popular_model.dart';
import 'package:http/http.dart' as http;
class ApiPopular{
  Uri link = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=d7236b730825fb7b3c7e23e7d91e473c');

  Future<List<PopularModel>?> getAllPopular() async {
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if(result.statusCode == 200){
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }

}