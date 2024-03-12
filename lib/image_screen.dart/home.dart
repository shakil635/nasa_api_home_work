import 'dart:convert';

import 'package:http/http.dart' as http;

/*
    1* add your ui desing and call backed
    2* Image.network(jsonList[index].href
    3* use index for load image in Image.network 
    4* userInput take a random "march",it remove when ui desing finish
    */

Future<List<dynamic>> getItems(String userInput) async {
  try {
    final response = await http
        .get(Uri.parse("https://images-api.nasa.gov/search?q=$userInput"));
    if (response.statusCode == 200) {
      //print(response.body);
      return jsonDecode(response.body)["collection"]["items"];
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    throw Exception(e);
  }
}

List<String> getLinks(List<dynamic> itemsList) {
  List<String> links = [];
  for (var item in itemsList) {
    for (var link in item['links']) {
      links.add(link['href']);
    }
  }
  return links;
}

void main() async {
  final items = await getItems("Blue");
  final links = getLinks(items);
  print(links.join('\n'));
}
