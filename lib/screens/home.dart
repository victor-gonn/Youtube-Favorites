import 'package:flutter/material.dart';
import 'package:youtube_favoritos/components/data-search.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Text("0"),
        ),
          IconButton(onPressed: (){}, 
         
          icon: Icon(Icons.star)
          ),
          IconButton(onPressed: () async {
           String? result = await showSearch(context: context, delegate: DataSearch());
           print(result);
          }, 
          icon: Icon(Icons.search)
          )
        ],
      ),
      body: Container(),
    );
  }
}