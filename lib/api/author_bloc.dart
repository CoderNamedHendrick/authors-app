import 'dart:async';
import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';

class AuthorsBloc {
  final AuthorApi _api = AuthorApi();
  StreamController<List<Author>> authorsController =
      StreamController<List<Author>>();

  Future<void> getAuthors() async {
    final response = await _api.getAuthors();
    authorsController.sink.add(response);
  }
}
