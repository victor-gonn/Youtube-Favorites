import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favoritos/bloc/FavoriteBloc.dart';
import 'package:youtube_favoritos/bloc/VideoBloc.dart';
import 'package:youtube_favoritos/components/data-search.dart';
import 'package:youtube_favoritos/models/video-model.dart';
import 'package:youtube_favoritos/screens/favorites_screen.dart';
import 'package:youtube_favoritos/widgets/video_tile.dart';


class Home extends StatelessWidget {
   Home({super.key});

   

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: Image.asset("images/image.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [ Align(
          alignment: Alignment.center,
          child: StreamBuilder<Map<String, Video>>(
            stream: BlocProvider.getBloc<FavoritesBloc>().outFav, 
            builder: (context, snapShot) {
              if(snapShot.hasData) {
                return Text("${snapShot.data!.length}");
              } else {
                return CircularProgressIndicator();
              }
            })
        ),
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>FavScreen()));
          }, 
         
          icon: Icon(Icons.star)
          ),
          IconButton(onPressed: () async {
           String? result = await showSearch(context: context, delegate: DataSearch());
           if(result != null) bloc.inSearch.add(result);
          }, 
          icon: Icon(Icons.search)
          )
        ],
      ),
      body: StreamBuilder(stream: bloc.outVideos, builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(itemBuilder: (context, index){
            if(index < snapshot.data.length) {
              return VideoTile(video: snapshot.data[index],);

            } else if(index >1) {
              bloc.inSearch.add(null);
              return Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
              );
            } else {
              return Container();
            }
            

          },
          itemCount: snapshot.data.length + 1,);
        } else{
          return Container();
        } 

      }),
      backgroundColor: Colors.black12,
    );
  }
}