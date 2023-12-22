import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favoritos/models/video-model.dart';

const API_KEY = "AIzaSyBM_cJ5vxAP7qUMKfnjIDtF2dJvJnWg0zE";

class Api {
  search(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"));

    decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      List<Video> videos = decode["items"].map<Video>((map) {
            return Video.fromJson(map);
          }).toList();
      return videos;
    } throw Exception('Failed to load videos',);
  }
}
















// urls :     "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"

  //  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"

  //  "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"