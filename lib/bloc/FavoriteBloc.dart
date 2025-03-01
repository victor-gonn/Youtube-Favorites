import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_favoritos/models/video-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final  _favController =
      BehaviorSubject<Map<String, Video>>.seeded({});
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoritesBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")as String).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();
        _favController.add(_favorites);
        
        
      }
    });
  }

  void toggleFav(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
      print("PREF: $prefs");
      print("FAVORITESSS:   $_favorites");
    });
    
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favController.close();
    
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
