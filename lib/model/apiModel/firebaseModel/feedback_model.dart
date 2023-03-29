class FeedbackModel {
  String? time;
  String? feedback;
  String? driverId;

  FeedbackModel({
    this.time,
    this.feedback,
    this.driverId,
  });

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    feedback = json['feedback'];
    driverId = json['driverid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['feedback'] = feedback;
    data['driverid'] = driverId;
    return data;
  }
}
