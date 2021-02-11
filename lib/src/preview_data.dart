import 'package:meta/meta.dart';

/// A class that represents data obtained from the web link.
///
/// See https://github.com/flyerhq/flutter_link_previewer
@immutable
class PreviewData {
  PreviewData({
    this.description,
    this.image,
    this.link,
    this.title,
  });

  final String description;
  final PreviewDataImage image;
  final String link;
  final String title;

  PreviewData.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        image = PreviewDataImage.fromJson(json['image']),
        link = json['link'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'image': image.toJson(),
        'link': link,
        'title': title,
      };
}

/// A utility class that forces image's width and height to be stored
/// alongside the url.
///
/// See https://github.com/flyerhq/flutter_link_previewer
@immutable
class PreviewDataImage {
  const PreviewDataImage({
    @required this.height,
    @required this.url,
    @required this.width,
  });

  final double height;
  final String url;
  final double width;

  PreviewDataImage.fromJson(Map<String, dynamic> json)
      : height = json['height'],
        url = json['url'],
        width = json['width'];

  Map<String, dynamic> toJson() => {
        'height': height,
        'url': url,
        'width': width,
      };
}
