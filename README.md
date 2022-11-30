# naver_crawling

#### 영화 코드를 가지고 네이버 영화에서 예고편 쿼리 정보(videoCD) 크롤링하기

```dart
class _NaverCrawlerState extends State<NaverCrawler> {

  var trailer = <String>[];
  var main_trailer = '';

  var movieCd = '';
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
  }
}
```



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
