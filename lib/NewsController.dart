import 'dart:convert';

import 'package:covid_api/model/newses.dart';
import 'package:http/http.dart' as http;

class NewsContoller {
  Future<List<Newses>> getnews() async {
    var url = Uri.parse(
        "https://covid-19-news.p.rapidapi.com/v1/covid?lang=id&media=true");
    var response = await http.get(url, headers: {
      'X-RapidAPI-Key': '80acae05c0msha9cffe430735355p153ecdjsn43b3cf277656',
      'X-RapidAPI-Host': 'covid-19-news.p.rapidapi.com'
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var newsList = jsonData['articles'] as List<dynamic>;
      var newses = newsList.map((e) => Newses.fromJson(e)).toList();
      return newses;
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}
