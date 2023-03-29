class PrepaidPlanResModel {
  String? status;
  int? count;
  List<Data>? data;

  PrepaidPlanResModel({this.status, this.count, this.data});

  PrepaidPlanResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? prepaidPlanName;
  String? registrationType;
  int? amount;
  int? discount;
  int? expiration;
  String? idTag;
  bool? publicAccessRestricted;

  Data({
    this.prepaidPlanName,
    this.registrationType,
    this.amount,
    this.discount,
    this.expiration,
    this.idTag,
    this.publicAccessRestricted,
  });

  Data.fromJson(Map<String, dynamic> json) {
    prepaidPlanName = json['prepaidPlanName'];
    registrationType = json['registrationType'];
    amount = json['amount'];
    discount = json['discount'];
    expiration = json['expiration'];
    idTag = json['idTag'];
    publicAccessRestricted = json['publicAccessRestricted'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prepaidPlanName'] = prepaidPlanName;
    data['registrationType'] = registrationType;
    data['amount'] = amount;
    data['discount'] = discount;
    data['expiration'] = expiration;
    data['idTag'] = idTag;
    data['publicAccessRestricted'] = publicAccessRestricted;
    return data;
  }
}
