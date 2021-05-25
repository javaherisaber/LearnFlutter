import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:learn/src/news/models/item_model.dart';

class NewsApiProvider {
  static final _baseUrl = 'https://hacker-news.firebaseio.com/v0';
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get(Uri.parse('$_baseUrl/topstories.json'));
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_baseUrl/item/$id.json'));
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}