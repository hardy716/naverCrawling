import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:url_launcher/url_launcher.dart';

class YoutubeCrawler extends StatefulWidget {
  const YoutubeCrawler({Key? key}) : super(key: key);

  @override
  State<YoutubeCrawler> createState() => _YoutubeCrawlerState();
}

class _YoutubeCrawlerState extends State<YoutubeCrawler> {

  var trailer = <String>[];
  var main_trailer = '';

  var movieNm = '올빼미';
  var videoCd = '';

  void _getYoutubeTrailer() async {
    final youtubeUrl = 'https://www.youtube.com/results?search_query=${movieNm} 메인 예고편';
    final response = await http.get(
      Uri.parse(
        youtubeUrl
      )
    );

    dom.Document document = parse.parse(response.body);

    final thumb = document.getElementsByTagName('a');

    print(thumb);
  }
      
  @override
  void initState() {
    _getYoutubeTrailer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      children: [
        Text(""),
      ],
    )));
  }
}