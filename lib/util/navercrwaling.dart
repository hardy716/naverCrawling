import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:url_launcher/url_launcher.dart';

class NaverCrawler extends StatefulWidget {
  const NaverCrawler({Key? key}) : super(key: key);

  @override
  State<NaverCrawler> createState() => _NaverCrawlerState();
}

class _NaverCrawlerState extends State<NaverCrawler> {

  var trailer = <String>[];
  var main_trailer = '';

  var movieCd = '184516';
  var videoCd = '';

  void _getNaverTrailer() async {
    final naverUrl = 'https://movie.naver.com/movie/bi/mi/media.naver?code=${movieCd}';
    final response = await http.get(
      Uri.parse(
        naverUrl
      )
    );

    dom.Document document = parse.parse(response.body);

    final thumb = document.getElementsByClassName('video_thumb');
      
    trailer = thumb
        .map((element) => element.getElementsByTagName('li')[0].innerHtml)
        .toList();
    trailer = trailer[0].split("=");
    movieCd = "${trailer[2].substring(0,6)}";
    videoCd = "${trailer[3].split("#")[0]}#tab";

    final Uri naverTrailer = Uri(
      scheme: 'https',
      host: 'movie.naver.com',
      path: 'movie/bi/mi/mediaView.naver',
      queryParameters:{
        "code" : movieCd,
        "mid" : videoCd,
      },
    );
    if (!await launchUrl(naverTrailer)) {
      throw 'Could not launch $naverTrailer';
    }
    print(movieCd);
    print(videoCd);
    print(naverTrailer);
    // https://movie.naver.com/movie/bi/mi/mediaView.naver?code=222301&mid=53546#tab
  
}

  @override
  void initState() {
    _getNaverTrailer();
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