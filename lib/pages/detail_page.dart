import 'package:covid_api/model/newses.dart';
import 'package:covid_api/pages/home_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.news});
  final Newses news;
  @override
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
            onPressed: () {},
            icon: Icon(
              Icons.bookmark,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${news.title}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            Text("${news.author}"),
            Text(
              "${news.publishedDate}",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            SizedBox(height: 10),
            Text("${news.summary}"),
          ],
        ),
      ),
    );
  }
}
