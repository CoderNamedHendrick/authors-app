import 'dart:convert';

import 'package:codemagic_test/models/author.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('API tests', () {
    List<Author> authors = [];

    test('Get authors from API', () async {
      final response = await http.get(
        Uri.parse('https://quotable.io/authors?page=30'),
      );
      final body = jsonDecode(response.body);
      if (body['results'] is List) {
        body['results'].forEach((e) {
          authors.add(Author.fromJson(e));
        });
      }
      print(authors);
    });

    // testWidgets('Display image', (WidgetTester tester) async {});
  });
}
