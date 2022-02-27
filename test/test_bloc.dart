import 'dart:io';

import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'api_test.mocks.dart';

class TestBloc extends AuthorsBloc {
  TestBloc() {
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
    _api = AuthorApi(client);
  }
  late final AuthorApi _api;

  @override
  Future<void> getAuthors() async {
    try {
      final response = await _api.getAuthors();
      authorsController.sink.add(response.results);
    } catch (e) {
      authorsController.sink.addError(e);
    }
  }
}
