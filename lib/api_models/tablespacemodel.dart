import 'package:dbmonitor/api_models/basemodel.dart';

class TablespaceModel extends BaseModel {
  String tablespacename;
  double sizemb;
  double freemb;
  double maxsizemb;
  double maxfreemb;
  double freepct;
  double usedpct;
  String status;

  TablespaceModel(
      {this.tablespacename,
      this.sizemb,
      this.freemb,
      this.maxsizemb,
      this.maxfreemb,
      this.freepct,
      this.usedpct,
      this.status});

  TablespaceModel.fromJson(Map<String, dynamic> json) {
    tablespacename = json['TABLESPACE_NAME'];
    sizemb = json['SIZE_MB'];
    freemb = json['FREE_MB'];
    maxsizemb = json['MAX_SIZE_MB'];
    maxfreemb = json['MAX_FREE_MB'];
    freepct = json['FREE_PCT'];
    usedpct = json['USED_PCT'];
    status = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TABLESPACE_NAME'] = this.tablespacename;
    data['SIZE_MB'] = this.sizemb;
    data['FREE_MB'] = this.freemb;
    data['MAX_SIZE_MB'] = this.maxsizemb;
    data['MAX_FREE_MB'] = this.maxfreemb;
    data['FREE_PCT'] = this.freepct;
    data['USED_PCT'] = this.usedpct;
    data['STATUS'] = this.status;
    return data;
  }
}
