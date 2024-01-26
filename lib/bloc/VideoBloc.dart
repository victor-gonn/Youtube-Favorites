import 'dart:async';
import 'dart:ui';
import 'package:youtube_favoritos/api.dart';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favoritos/models/video-model.dart';

class VideosBloc implements BlocBase {
   late Api api;

   late List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String?> _searchController = StreamController<String?>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(dynamic search) async {
    if(search != null) {
       _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    
    _videosController.sink.add(videos);

   
   
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
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
