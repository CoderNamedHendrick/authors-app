import 'dart:convert';
import 'package:codemagic_test/models/authors.dart';
import 'package:http/http.dart' as http;

class AuthorApi {
  final http.Client client;
  AuthorApi(this.client);
  static String authorImage(String slug) {
    return 'https://images.quotable.dev/profile/400/$slug.jpg';
  }

  Future<Authors> getAuthors() async {
    final response = await client.get(
      Uri.parse('https://quotable.io/authors'),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final result = Authors.fromJson(body);
      return result;
    } else {
      throw Exception('Failed to get authors');
    }
  }
}
