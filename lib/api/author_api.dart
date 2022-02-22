import 'dart:convert';
import 'package:codemagic_test/models/author.dart';
import 'package:http/http.dart' as http;

class AuthorApi {
  static String authorImage(String slug) {
    return 'https://images.quotable.dev/profile/400/$slug.jpg';
  }

  Future<List<Author>> getAuthors([page = 1]) async {
    List<Author> authors = [];
    final response = await http.get(
      Uri.parse('https://quotable.io/authors?page=$page'),
    );
    final body = jsonDecode(response.body);
    if (body['results'] is List) {
      body['results'].forEach((e) {
        authors.add(Author.fromJson(e));
      });
    }
    return authors;
  }
}
