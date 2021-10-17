

import 'package:movie_app_bloc/model/video/video.dart';

class VideoResponse {
  final Video videos;

  VideoResponse(this.videos);

  VideoResponse.fromJson(Map<String, dynamic> json)
      : videos = (json["results"] as List)
      .map((i) => new Video.fromJson(i))
      .first;
}
