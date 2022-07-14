import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_search/models/image_results.dart';
import 'package:localstorage/localstorage.dart';

class ImageResultService {

  final String? _authKey = dotenv.env['PEXEL_KEY'];
  final LocalStorage storage = LocalStorage('PEXEL_API');

  Future<List<ImageResult>?> getAll(text) async {
    final jsonCache = storage.getItem(text);
    if(await storage.ready && jsonCache != null) {
      return List<ImageResult>.from(jsonCache['photos']?.map((json) => ImageResult.fromJson(json)).toList());
    }
    if(_authKey == null) {
      throw Exception('You must create an auth key for PEXEL_KEY and add it to a .env file in the root directory');
    }
    String searchUrl = 'https://api.pexels.com/v1/search?query=$text&per_page=30';
    final http.Response response = await http.get(Uri.parse(searchUrl), headers: {
      'Content-type': 'application/json',
      'Authorization': _authKey!,
    });
    if(response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if(jsonResponse['photos'] != null ) {
        storage.setItem(text, jsonResponse);
        return List<ImageResult>.from(jsonResponse['photos']?.map((json) => ImageResult.fromJson(json)).toList());
      }
    }
    throw Exception('Failed to fetch ImageResult ${response.statusCode} : ${response.body}',);
  }
}