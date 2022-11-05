import 'package:equatable/equatable.dart';

class LoremImageInfo extends Equatable {
  const LoremImageInfo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  @override
  List<Object?> get props => [id, author, url];
}
