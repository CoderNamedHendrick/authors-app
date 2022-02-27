import 'dart:io';
import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:codemagic_test/models/authors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api_test.mocks.dart';
import 'test_bloc.dart';

@GenerateMocks([http.Client])
void main() {
  test('Get authors from API', () async {
    final client = MockClient();
    when(client.get(Uri.parse('https://quotable.io/authors'))).thenAnswer(
      (_) async => http.Response(
        File('test/test_resources/authors.json').readAsStringSync(),
        200,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    expect(await AuthorApi(client).getAuthors(), isA<Authors>());
  });

  test('throw an exception if we get an error', () async {
    final client = MockClient();
    when(client.get(Uri.parse('https://quotable.io/authors'))).thenAnswer(
      (_) async => http.Response('Not found', 400),
    );
    expect(AuthorApi(client).getAuthors(), throwsException);
  });

  test('test if list of authors are emitted from the bloc', () async {
    final bloc = TestBloc();
    await bloc.getAuthors();

    expect(bloc.authorsController.stream, emits(isA<List<Author>>()));
  });
}
