class ServiceModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String description;
  final String tags;
  final String? videoUrl;

  ServiceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.description,
    required this.tags,
    this.videoUrl,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      image: json['imgUrl'] ?? '',
      description: json['description'] ?? '',
      tags: json['tags'] ?? '',
      videoUrl: json['videoUrl'],
    );
  }
}
