import 'package:sqflite/sqflite.dart';

class Newses {
  String? summary;
  String? country;
  String? author;
  String? link;
  String? media;
  String? title;
  String? topic;
  String? publishedDate;
  String? sId;
  double? dScore;

  Newses(
      {this.summary,
      this.country,
      this.author,
      this.link,
      this.media,
      this.title,
      this.topic,
      this.publishedDate,
      this.sId,
      this.dScore});

  Newses.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    country = json['country'];
    author = json['author'];
    link = json['link'];
    media = json['media'];
    title = json['title'];
    topic = json['topic'];
    publishedDate = json['published_date'];
    sId = json['_id'];
    dScore = json['_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    data['country'] = this.country;
    data['author'] = this.author;
    data['link'] = this.link;
    data['media'] = this.media;
    data['title'] = this.title;
    data['topic'] = this.topic;
    data['published_date'] = this.publishedDate;
    data['_id'] = this.sId;
    data['_score'] = this.dScore;
    return data;
  }

  factory Newses.fromMap(Map<String, dynamic> map) {
    return Newses(
      summary: map['summary'],
      country: map['country'],
      author: map['author'],
      link: map['link'],
      media: map['media'],
      title: map['title'],
      topic: map['topic'],
      publishedDate: map['published_date'],
      sId: map['_id'],
      dScore: map['_score']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'summary': summary,
      'country': country,
      'author': author,
      'link': link,
      'media': media,
      'title': title,
      'topic': topic,
      'published_date': publishedDate,
      'sId': sId,
      'score': dScore,
    };
  }

  Future<void> insertToDatabase(Database database) async {
    await database.insert('news', toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
