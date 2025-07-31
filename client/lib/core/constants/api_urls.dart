class ApiUrls {
  //static const baseURL = 'http://192.168.1.15:3000';
  static const registerURL = '/api/auth/register';
  static const userProfileURL = '/api/auth/profile';
  static const loginURL = '/api/auth/login';
  static const gforgetPassURL = '/api/auth/forget-password';
  static const resetPassURL = '/api/auth/forget-password';
  static const verifyOtpURL = '/api/auth/verify';

  static const messagesURL = '/api/chatbot/room/:id';
  static const chatroomURL = '/api/chatbot/rooms';
  static const createRoomsURL = '/api/chatbot/create';
  static const renameRoomURL = '/api/chatbot/rename';
  static const scanURL = '/api/scan/upload';
  static const getMesByRoomIdURL = '/api/message/:id';

}