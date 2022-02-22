import 'author.dart';

class Authors {
  int count, totalCount, page, totalPages, lastItemIndex;
  List<Author> results;

  Authors({
    required this.count,
    required this.totalCount,
    required this.page,
    required this.totalPages,
    required this.lastItemIndex,
    required this.results,
  });

  factory Authors.fromJson(Map<String, dynamic> json) {
    // List<Author> authors = [];
    // if (json['results'] is List) {
    //   json['results'].forEach((e) {
    //     authors.add(Author.fromJson(e));
    //   });
    // }

    return Authors(
      count: json['count'],
      totalCount: json['totalCount'],
      page: json['page'],
      totalPages: json['totalPages'],
      lastItemIndex: json['lastItemIndex'],
      results:
          (json['results'] as List).map((e) => Author.fromJson(e)).toList(),
    );
  }
}
