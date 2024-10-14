class StatusCountWrapperModel {
  String? status;
  List<StatusCountModel>? data;

  StatusCountWrapperModel({this.status, this.data});

  StatusCountWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StatusCountModel>[];
      json['data'].forEach((v) {
        data!.add(StatusCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusCountModel {
  String? sId;
  int? sum;

  StatusCountModel({this.sId, this.sum});

  StatusCountModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
