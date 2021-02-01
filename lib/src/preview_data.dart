import 'package:meta/meta.dart';

class PreviewData {
  PreviewData({
    this.description,
    this.image,
    this.link,
    this.title,
  });

  String description;
  PreviewDataImage image;
  String link;
  String title;

  PreviewData.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        image = json['image'],
        link = json['link'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'image': image,
        'link': link,
        'title': title,
      };
}

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
