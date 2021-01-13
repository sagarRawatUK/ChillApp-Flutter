import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ChillApp/views/image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

final Color bgColor = Color(0xff2f3640);
final Color darkColor = Color(0xff2f3640);
final Color lightColor = Colors.white;

class MyMainApp extends StatefulWidget {
  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  static String query = "wallpapers";
  List<dynamic> wallpapersList;
  Icon searchIcon = Icon(Icons.search);
  Widget searchBar = Text(
    "FotoApp",
    style: TextStyle(
        fontWeight: FontWeight.w800,
        letterSpacing: .5,
        fontFamily: "DancingScript",
        fontSize: 20),
  );

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    var apiUrl =
        "https://api.pexels.com/v1/search?query=" + query + "&per_page=500";
    http.Response response = await http.get(
      apiUrl,
      headers: {
        HttpHeaders.authorizationHeader:
            "563492ad6f91700001000001999da5bd71d04ece9af9ba1a03e8beaf"
      },
    );
    if (response.statusCode == 200) {
      try {
        final responseJson = jsonDecode(response.body);
        setState(() {
          wallpapersList = responseJson['photos'];
        });
      } catch (e) {
        print(e);
      }
    } else
      print(response.reasonPhrase);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "DancingScript"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: searchBar,
          backgroundColor: bgColor,
          actions: [
            IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 18)),
                      onSubmitted: (value) {
                        query = value;
                        initialize();
                        print(query);
                      },
                    );
                  } else {
                    this.searchIcon = Icon(Icons.search);
                    this.searchBar = Text("FotoApp",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: .5,
                            fontFamily: "DancingScript",
                            fontSize: 20));
                  }
                });
              },
              color: Colors.white,
            )
          ],
        ),
        body: wallpapersList != null
            ? StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(10.0),
                crossAxisCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  String imgPath = wallpapersList[index]["src"]["large"];
                  return Card(
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePath(imgPath))),
                      child: Hero(
                          tag: imgPath,
                          child: FadeInImage(
                            width: MediaQuery.of(context).size.width,
                            placeholder: AssetImage("assets/loading.png"),
                            image: NetworkImage(imgPath),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                },
                staggeredTileBuilder: (index) =>
                    StaggeredTile.count(2, index.isEven ? 2 : 3),
                itemCount: wallpapersList.length,
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
        backgroundColor: bgColor,
      ),
    );
  }
}
