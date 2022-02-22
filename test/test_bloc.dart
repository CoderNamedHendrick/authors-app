import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/api/author_bloc.dart';
import 'package:http/http.dart' as http;

class TestBloc extends AuthorsBloc {
  TestBloc(http.Client client) {
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
