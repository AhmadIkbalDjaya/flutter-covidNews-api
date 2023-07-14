import 'package:covid_api/model/dbHelper.dart';
import 'package:covid_api/model/newses.dart';
import 'package:covid_api/pages/home_page.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  List<Newses> newses = [];

  Future<dynamic> fetchFavorite() async {
    try {
      final news = await DBHelper.getAllNews();
      setState(() {
        newses = news;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFavorite();
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
          final news = newses[index];
          return NewsBox(news: news);
        },
      ),
    );
  }
}
