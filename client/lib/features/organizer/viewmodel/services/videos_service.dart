import 'package:client/features/organizer/data/model/video.dart';

import 'package:hive_ce/hive.dart';

late Box<Video> videosBox;

class VideosService {
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(VideoAdapter());
    }
    videosBox = await Hive.openBox<Video>('videosData');
  }
}