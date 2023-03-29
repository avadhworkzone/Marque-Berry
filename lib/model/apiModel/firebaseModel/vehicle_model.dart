// ignore_for_file: file_names

class VehicleModel {
  String? vehicleType;
  String? modelName;
  String? brandName;
  String? driverId;
  DateTime? datetime;
  String? vehiclePlugType;

  VehicleModel({
    this.vehicleType,
    this.modelName,
    this.brandName,
    this.driverId,
    this.vehiclePlugType,
    this.datetime,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleType = json['vehicletype'];
    modelName = json['modelname'];
    brandName = json['brandname'];
    driverId = json['driverid'];
    vehiclePlugType = json['vehicleplugtype'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicletype'] = vehicleType;
    data['modelname'] = modelName;
    data['brandname'] = brandName;
    data['driverid'] = driverId;
    data['vehicleplugtype'] = vehiclePlugType;
    data['datetime'] = datetime ?? DateTime.now();
    return data;
  }
}
