import 'package:codemagic_test/api/author_api.dart';
import 'package:codemagic_test/models/author.dart';
import 'package:flutter/material.dart';

class AuthorDetailsScreen extends StatelessWidget {
  const AuthorDetailsScreen({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
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
              background: Image.network(
                AuthorApi.authorImage(author.slug),
                fit: BoxFit.cover,
              ),
              title: Hero(
                tag: author.slug,
                child: Text(
                  author.name,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            key: const ValueKey('author-sliver'),
            child: AuthorDetails(author: author),
          ),
        ],
      ),
    );
  }
}

class AuthorDetails extends StatelessWidget {
  const AuthorDetails({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(width: 12),
              Text(
                author.name,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  author.description,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ],
          ),
          Text(
            'Bio',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              author.bio,
              key: const ValueKey('bio-info'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
