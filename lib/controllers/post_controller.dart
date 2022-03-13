import 'package:flutter/rendering.dart';
import 'package:flutter_api/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostController {
  Future<List<PostModel>?> getPost() async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        var json = response.body;
        return postModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('GetPost error => $e');
      return null;
    }
  }
}
