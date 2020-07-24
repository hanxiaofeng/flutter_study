import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

class NetRequestModel {
  String message;
  int code;
  List<Article> result = [];

  NetRequestModel({this.code, this.message, this.result});

  factory NetRequestModel.from(Map<String, dynamic> parsedJson) {
    return NetRequestModel(
      code: parsedJson['code'],
      message: parsedJson['message'],
      result: (parsedJson['result'] as List)
          .map((i) => Article.fromJson(i))
          .toList(),
    );
  }
}

class Article {
  String sid;
  String text;
  String type;
  String thumbnail;
  String video;
  Object images;
  String up;
  String down;
  String forward;
  String comment;
  String uid;
  String name;
  String header;
  String top_comments_content;
  String top_comments_voiceuri;
  String top_comments_uid;
  String top_comments_name;
  String top_comments_header;
  String passtime;

  Article(
      {this.sid,
      this.text,
      this.type,
      this.thumbnail,
      this.video,
      this.images,
      this.up,
      this.down,
      this.forward,
      this.comment,
      this.uid,
      this.name,
      this.header,
      this.top_comments_content,
      this.top_comments_voiceuri,
      this.top_comments_uid,
      this.top_comments_name,
      this.top_comments_header,
      this.passtime});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
      sid: parsedJson["sid"],
      text: parsedJson["text"],
      type: parsedJson["type"],
      thumbnail: parsedJson["thumbnail"],
      video: parsedJson["video"],
      images: parsedJson["images"],
      up: parsedJson["up"],
      down: parsedJson["down"],
      forward: parsedJson["forward"],
      comment: parsedJson["comment"],
      uid: parsedJson["uid"],
      name: parsedJson["name"],
      header: parsedJson["header"],
      top_comments_content: parsedJson["top_comments_content"],
      top_comments_voiceuri: parsedJson["top_comments_voiceuri"],
      top_comments_uid: parsedJson["top_comments_uid"],
      top_comments_name: parsedJson["top_comments_name"],
      top_comments_header: parsedJson["top_comments_header"],
      passtime: parsedJson["passtime"],
    );
  }
}
