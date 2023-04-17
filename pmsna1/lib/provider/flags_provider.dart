import 'package:flutter/material.dart';

class FlagsProvider with ChangeNotifier {
  // ignore: non_constant_identifier_names
  bool _postList_Flag = false;
  // ignore: non_constant_identifier_names
  bool _eventList_Flag = false;
  // ignore: non_constant_identifier_names
  bool _moviesList_Flag = false;

  // ignore: non_constant_identifier_names
  getFlag_postList() => _postList_Flag;
  // ignore: non_constant_identifier_names
  setFlag_postList() {
    _postList_Flag = !_postList_Flag;
    notifyListeners();
  }

  getFlag_eventList() => _eventList_Flag;
  // ignore: non_constant_identifier_names
  setFlag_eventList() {
    _eventList_Flag = !_eventList_Flag;
    notifyListeners();
  }

  getFlag_movieList() => _moviesList_Flag;
  // ignore: non_constant_identifier_names
  setFlag_movieList() {
    _moviesList_Flag = !_moviesList_Flag;
    notifyListeners();
  }
}