import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:codemagic_test/views/wiki_webview.dart';
import 'package:flutter/material.dart';

class AuthorDetails extends StatelessWidget {
  const AuthorDetails({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    print(author.link);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // automaticallyImplyLeading: false,
            expandedHeight: 200,
            pinned: true,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              centerTitle: false,
              background: Hero(
                tag: author.slug,
                child: Image.network(
                  AuthorApi.authorImage(author.slug),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                author.name,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        author.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        author.description,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bio',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                        author.bio,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Wiki(wikiUrl: author.link),
                      ),
                    ),
                    child: Text(
                      'click this text to read wiki',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
