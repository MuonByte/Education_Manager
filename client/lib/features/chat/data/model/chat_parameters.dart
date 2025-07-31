import 'dart:io';

class ChatRoomModel {
  final String roomId;
  final String roomName;

  ChatRoomModel({
    required this.roomId,
    required this.roomName,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      roomId: json['id']?.toString() ?? 'unknown-id',
      roomName: json['title']?.toString() ?? 'Unnamed Room',
    );
  }
}

class UserMessageData {
  final String id;
  final String content;
  final String sender;
  final DateTime sendAt;
  final String usersId;
  final String chatbotRoomsId;

  UserMessageData({
    required this.id,
    required this.content,
    required this.sender,
    required this.sendAt,
    required this.usersId,
    required this.chatbotRoomsId,
  });

  factory UserMessageData.fromJson(Map<String, dynamic> json) {
    return UserMessageData(
      id: json['id'],
      content: json['content'],
      sender: json['sender'],
      sendAt: DateTime.parse(json['send_at']),
      usersId: json['users_id'],
      chatbotRoomsId: json['chatbot_rooms_id'],
    );
  }
}

class AIMessageData {
  final String id;
  final String content;
  final String sender;
  final DateTime sendAt;
  final String usersId;
  final String chatbotRoomsId;

  AIMessageData({
    required this.id,
    required this.content,
    required this.sender,
    required this.sendAt,
    required this.usersId,
    required this.chatbotRoomsId,
  });

  factory AIMessageData.fromJson(Map<String, dynamic> json) {
    return AIMessageData(
      id: json['id'],
      content: json['content'],
      sender: json['sender'],
      sendAt: DateTime.parse(json['send_at']),
      usersId: json['users_id'],
      chatbotRoomsId: json['chatbot_rooms_id'],
    );
  }
}

class MessageModel {
  final UserMessageData? userMessage;
  final AIMessageData? aIMessage;

  MessageModel({
    this.userMessage,
    this.aIMessage,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userMessage: json['userMessage'] != null
          ? UserMessageData.fromJson(json['userMessage'])
          : null,
      aIMessage: json['AIMessage'] != null
          ? AIMessageData.fromJson(json['AIMessage'])
          : null,
    );
  }

}
  extension MessageModelHelpers on MessageModel {
    bool isFromUser(String currentUserId) {
      return userMessage != null && userMessage!.usersId == currentUserId;
    }

    String get content {
      return userMessage?.content ?? aIMessage?.content ?? '';
    }
  }

class CreateChatRoomParams {
  final String roomName;

  CreateChatRoomParams({required this.roomName});

  Map<String, dynamic> toMap() => {"roomName": roomName};
}

class FetchChatRoomsParams {
final String? id;

  FetchChatRoomsParams({
    this.id,

  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}

class SendMessageParams {
  final String roomId;
  final String? content;
  final File? imageFile;
  final String userId;
  final String? senderUsername;

  SendMessageParams({
    required this.roomId,
    this.content,
    this.imageFile,
    required this.userId,
    this.senderUsername,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'imageUrl': imageFile?.path,
      'userId': userId,
      'senderUsername': senderUsername,
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
