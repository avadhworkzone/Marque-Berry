class PaymentMethodResModel {
  int? amount;
  String? expiryDate;
  String? paymentMode;
  String? prepaidPlanName;
  bool? automaticTopUp;

  PaymentMethodResModel({
    this.amount,
    this.expiryDate,
    this.paymentMode,
    this.prepaidPlanName,
    this.automaticTopUp,
  });

  PaymentMethodResModel.fromJson(Map<String, dynamic> json) {
    amount = json['Amount'];
    expiryDate = json['expiryDate'];
    paymentMode = json['paymentMode'];
    prepaidPlanName = json['prepaidPlanName'];
    automaticTopUp = json['automaticTopUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Amount'] = amount;
    data['expiryDate'] = expiryDate;
    data['paymentMode'] = paymentMode;
    data['prepaidPlanName'] = prepaidPlanName;
    data['automaticTopUp'] = automaticTopUp;
    return data;
  }
}
