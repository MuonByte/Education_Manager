import 'package:client/features/organizer/data/model/video.dart';
import 'package:client/features/organizer/viewmodel/services/videos_service.dart';

class VideoTrackerViewModel {
  void addVideo({
    required String name,
    required String subject,
    required String status,
    String? videoLink,
  }) {
    if (name.trim().isEmpty || subject.trim().isEmpty || status.trim().isEmpty) return;

    videosBox.put(
      'VideoKey_$name',
      Video(
        name: name,
        subject: subject,
        status: status,
        videoLink: videoLink,
      ),
    );
  }

  void deleteVideo(int index) {
    videosBox.deleteAt(index);
  }

  void updateVideoStatus(int index, String newStatus) {
    final Video? video = videosBox.getAt(index);

    if (video != null) {
      final updatedVideo = Video(
        name: video.name,
        subject: video.subject,
        status: newStatus,
      );

      videosBox.putAt(index, updatedVideo);
    }
  }

  void updateVideo({
    required int index,
    required String newStatus,
    String? newVideoLink,
  }) {
    final oldVideo = videosBox.getAt(index);
    if (oldVideo == null) return;

    final updatedVideo = Video(
      name: oldVideo.name,
      subject: oldVideo.subject,
      status: newStatus,
      videoLink: newVideoLink ?? oldVideo.videoLink,
      feedback: oldVideo.feedback,
    );

    videosBox.putAt(index, updatedVideo);
  }
}