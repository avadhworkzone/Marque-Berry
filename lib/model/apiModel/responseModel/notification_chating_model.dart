class NotificationChattingModel {
  String? senderId;
  String? senderImage;
  String? senderName;
  String? receiverFcmToken;
  String? receiverId;
  String? receiverImage;
  String? receiverName;

  NotificationChattingModel({
    this.receiverName,
    this.receiverImage,
    this.receiverId,
    this.receiverFcmToken,
    this.senderName,
    this.senderImage,
    this.senderId,
  });

  NotificationChattingModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderImage = json['senderImage'];
    senderName = json['senderName'];
    receiverFcmToken = json['receiverFcmToken'];
    receiverId = json['receiverId'];
    receiverImage = json['receiverImage'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'senderImage': senderImage,
        'senderName': senderName,
        'receiverFcmToken': receiverFcmToken,
        'receiverId': receiverId,
        'receiverImage': receiverImage,
        'receiverName': receiverName,
      };
}
