// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:codemagic_test/views/author_detail_screen.dart';
import 'package:codemagic_test/views/authors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codemagic_test/main.dart';
import 'package:mockito/mockito.dart';
import 'api_test.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Show Exception', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 4));
    expect(find.text('Exception: Failed to get authors'), findsOneWidget);
  });

  group('Tests with mocked client', () {
    final client = MockClient();

    setUp(
      () =>
          when(client.get(Uri.parse('https://quotable.io/authors'))).thenAnswer(
        (_) async => http.Response(
          File('test/test_resources/authors.json').readAsStringSync(),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      ),
    );

    testWidgets('Populating the authors listViews',
        (WidgetTester tester) async {
      List<Author> authors = [];
      final response = await AuthorApi(client).getAuthors();
      authors = response.results;
      final listFinder = find.byType(Scrollable);
      final itemFinder = find.byKey(const ValueKey('author-10'));

      await tester.pumpWidget(
        MaterialApp(
          home: AuthorsListView(data: authors),
        ),
      );
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      expect(itemFinder, findsOneWidget);
    });

    testWidgets('Check if information in detail screen is displayed currently',
        (WidgetTester tester) async {
      List<Author> authors = [];
      final response = await AuthorApi(client).getAuthors();
      authors = response.results;

      await tester.pumpWidget(MaterialApp(
        home: AuthorDetails(author: authors[0]),
      ));

      expect(find.text(authors[0].name), findsOneWidget);
      expect(find.text(authors[0].description), findsOneWidget);
      expect(find.text(authors[0].bio), findsOneWidget);
    });
  });
}
