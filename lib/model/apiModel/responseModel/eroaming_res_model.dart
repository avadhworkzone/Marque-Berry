class EroamingResModel {
  List<Content>? content;
  Pageable? pageable;
  int? totalPages;
  bool? last;
  int? totalElements;
  Sort? sort;
  int? number;
  bool? first;
  int? numberOfElements;
  int? size;
  bool? empty;

  EroamingResModel({
    this.content,
    this.pageable,
    this.totalPages,
    this.last,
    this.totalElements,
    this.sort,
    this.number,
    this.first,
    this.numberOfElements,
    this.size,
    this.empty,
  });

  EroamingResModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    totalPages = json['totalPages'];
    last = json['last'];
    totalElements = json['totalElements'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    number = json['number'];
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['totalPages'] = totalPages;
    data['last'] = last;
    data['totalElements'] = totalElements;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['number'] = number;
    data['first'] = first;
    data['numberOfElements'] = numberOfElements;
    data['size'] = size;
    data['empty'] = empty;
    return data;
  }
}

class Content {
  String? stationName;
  double? gpsLat;
  double? gpsLong;
  String? street;
  String? city;
  String? postal;
  String? country;
  String? phone;
  String? lastUpdateTs;
  String? operatorId;
  String? operatorName;
  String? connectorName;
  String? power;
  String? plugType;
  String? status;

  Content({
    this.stationName,
    this.gpsLat,
    this.gpsLong,
    this.street,
    this.city,
    this.postal,
    this.country,
    this.phone,
    this.lastUpdateTs,
    this.operatorId,
    this.operatorName,
    this.connectorName,
    this.power,
    this.plugType,
    this.status,
  });

  Content.fromJson(Map<String, dynamic> json) {
    stationName = json['stationName'];
    gpsLat = json['gpsLat'];
    gpsLong = json['gpsLong'];
    street = json['street'];
    city = json['city'];
    postal = json['postal'];
    country = json['country'];
    phone = json['phone'];
    lastUpdateTs = json['lastUpdateTs'];
    operatorId = json['operatorId'];
    operatorName = json['operatorName'];
    connectorName = json['connectorName'];
    power = json['power'];
    plugType = json['plugType'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationName'] = stationName;
    data['gpsLat'] = gpsLat;
    data['gpsLong'] = gpsLong;
    data['street'] = street;
    data['city'] = city;
    data['postal'] = postal;
    data['country'] = country;
    data['phone'] = phone;
    data['lastUpdateTs'] = lastUpdateTs;
    data['operatorId'] = operatorId;
    data['operatorName'] = operatorName;
    data['connectorName'] = connectorName;
    data['power'] = power;
    data['plugType'] = plugType;
    data['status'] = status;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable({
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.offset,
    this.unpaged,
    this.paged,
  });

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    unpaged = json['unpaged'] = false;
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['offset'] = offset;
    data['unpaged'] = unpaged;
    data['paged'] = paged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
