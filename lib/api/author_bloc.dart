import 'dart:async';
import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:http/http.dart' as http;

abstract class AuthorsBloc {
  StreamController<List<Author>> authorsController = StreamController();
  Future<void> getAuthors();
}

class AppBloc extends AuthorsBloc {
  AppBloc() {
    final client = http.Client();
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
