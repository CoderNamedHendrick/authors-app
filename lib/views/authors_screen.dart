import 'package:codemagic_test/api/author_bloc.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:codemagic_test/views/author_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({Key? key}) : super(key: key);

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  late AuthorsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AppBloc(Client());
    _bloc.getAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Authors',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _bloc.getAuthors,
        child: StreamBuilder<List<Author>>(
          stream: _bloc.authorsController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return AuthorsListView(
                data: data,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.redAccent),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class AuthorsListView extends StatelessWidget {
  const AuthorsListView({Key? key, required this.data}) : super(key: key);
  final List<Author> data;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        key: const ValueKey('authors-list'),
        itemBuilder: (context, index) {
          return ListTile(
            key: ValueKey('author-$index'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AuthorDetailsScreen(author: data[index]),
              ),
            ),
            // leading: Hero(
            //   tag: data[index].slug,
            //   child: Image.network(
            //     AuthorApi.authorImage(data[index].slug),
            //   ),
            // ),
            title: Hero(
              tag: data[index].slug,
              child: Text(
                data[index].name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            subtitle: Text(
              data[index].description,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
