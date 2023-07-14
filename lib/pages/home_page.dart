import 'package:covid_api/NewsController.dart';
import 'package:covid_api/model/dbHelper.dart';
import 'package:covid_api/model/newses.dart';
import 'package:covid_api/pages/detail_page.dart';
import 'package:covid_api/pages/save_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsController = NewsContoller();
  List<Newses> newses = [];

  Future<dynamic> fetchData() async {
    try {
      List<Newses> fetchNews = await newsController.getnews();
      setState(() {
        newses = fetchNews;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text("COVID 19"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SavePage();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.bookmark,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: newses.length,
        itemBuilder: (context, index) {
          var news = newses[index];
          return Stack(
            children: [
              NewsBox(news: news),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () async {
                    try {
                      var result = await DBHelper.insertNews(news);
                      if (result) {
                        return showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.8),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Succes add to Favorite",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ));
                      }
                    } catch (e) {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("error ${e}"),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.bookmark_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NewsBox extends StatelessWidget {
  const NewsBox({
    super.key,
    required this.news,
  });

  final Newses news;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              news: news,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // padding: EdgeInsets.all(5),
        // height: 220,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Image.network(
                "https://picsum.photos/536/150?random=${news.sId}",
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${news.title}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${news.author}"),
                      Text(
                        "${news.publishedDate}",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
