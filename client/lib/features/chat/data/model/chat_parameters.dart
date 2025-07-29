class ChatRoomModel {
  final bool newRoom;
  final String roomName;
  final String roomId;

  ChatRoomModel({
    required this.newRoom,
    required this.roomName,
    required this.roomId,
  });
}

class MessageModel {
  final String messageId;
  final String messageText;
  final String? imageUrl;
  final String userId;
  final DateTime createdAt;

  MessageModel({
    required this.messageId,
    required this.messageText,
    this.imageUrl,
    required this.userId,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      messageText: json['messageText'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'messageText': messageText,
      'imageUrl': imageUrl,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}


class CreateChatRoomParams {
  final String roomName;

  CreateChatRoomParams({required this.roomName});

  Map<String, dynamic> toMap() => {"roomName": roomName};
}

class FetchChatRoomsParams {}

class SendMessageParams {
  final String roomId;
  final String messageText;
  final String? imageUrl;
  final String userId;

  SendMessageParams({
    required this.roomId,
    required this.messageText,
    this.imageUrl,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': messageText,
    };
  }
}

class FetchMessagesParams {
  final String roomId;

  FetchMessagesParams({required this.roomId});

  Map<String, dynamic> toMap() => {"roomId": roomId};
}

class DeleteChatRoomParams {
  final String roomId;

  DeleteChatRoomParams({required this.roomId});

  Map<String, dynamic> toMap() => {"roomId": roomId};
}