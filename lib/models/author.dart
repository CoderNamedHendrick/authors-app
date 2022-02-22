class Author {
  String link, bio, description, id, name, slug, dateAdded, dateModified;

  Author({
    required this.link,
    required this.bio,
    required this.description,
    required this.id,
    required this.name,
    required this.slug,
    required this.dateAdded,
    required this.dateModified,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      link: json['link'] ?? '',
      bio: json['bio'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      dateAdded: json['dateAdded'] ?? '',
      dateModified: json['dateModified'] ?? '',
    );
  }
}
