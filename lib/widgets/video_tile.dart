import 'package:flutter/material.dart';

import '../models/video-model.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final Video video;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(video.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      
                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(video.channel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),),
                  )
                ],
              ),
              ),
              IconButton(onPressed: (){}, 
              icon: Icon(Icons.star_border),
              color: Colors.white,)
            ],
          )
        ],
      ),
    );
  }
}
