class NotificationChattingModel {
  String? senderId;
  String? senderImage;
  String? senderName;
  String? senderUserName;
  String? receiverFcmToken;
  String? receiverId;
  String? receiverImage;
  String? receiverName;
  String? receiverUserName;

  NotificationChattingModel({
    this.receiverUserName,
    this.receiverName,
    this.receiverImage,
    this.receiverId,
    this.receiverFcmToken,
    this.senderName,
    this.senderUserName,
    this.senderImage,
    this.senderId,
  });

  NotificationChattingModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderImage = json['senderImage'];
    senderName = json['senderName'];
    senderUserName = json['senderUserName'];
    receiverFcmToken = json['receiverFcmToken'];
    receiverId = json['receiverId'];
    receiverImage = json['receiverImage'];
    receiverName = json['receiverName'];
    receiverUserName = json['receiverUserName'];
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'senderImage': senderImage,
        'senderName': senderName,
        'senderUserName': senderUserName,
        'receiverFcmToken': receiverFcmToken,
        'receiverId': receiverId,
        'receiverImage': receiverImage,
        'receiverName': receiverName,
        'receiverUserName': receiverUserName,
      };
}
