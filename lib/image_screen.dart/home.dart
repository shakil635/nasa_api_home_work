import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_image_and_video_api_test/models/model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = "march";
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    /*
    1* add your ui desing and call backed
    2* Image.network(jsonList[index].href
    3* use index for load image in Image.network 
    4* userInput take a random "march",it remove when ui desing finish
    */
  }

  List<NasaImageApi> jsonList = [];

  Future<List<NasaImageApi>> getData() async {
    try {
      final response = await http
          .get(Uri.parse("https://images-api.nasa.gov/search?q=$userInput"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["collection"]["items"];
        for (var item in data) {
          var links = item["links"];
          for (var link in links) {
            if (link["rel"] == "preview") {
              jsonList.add(NasaImageApi.fromJson(link));
            }
          }
        }
        print(jsonList);

        return jsonList;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
