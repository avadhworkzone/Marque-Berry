class GetWalletBalanceResModel {
  GetWalletBalanceResModel({
      this.status, 
      this.msg, 
      this.data,});

  GetWalletBalanceResModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WalletData.fromJson(v));
      });
    }
  }
  int? status;
  String? msg;
  List<WalletData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WalletData {
  WalletData({
      this.id, 
      this.userId, 
      this.balance,});

  WalletData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    balance = json['balance'];
  }
  int? id;
  String? userId;
  String? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['balance'] = balance;
    return map;
  }

}