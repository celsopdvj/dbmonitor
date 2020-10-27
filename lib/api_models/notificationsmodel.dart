class NotificationsModel {
  String rEASON;
  String cREATIONTIME;
  String sUGGESTEDACTION;
  String aDVISORNAME;
  double mETRICVALUE;
  String mESSAGETYPE;
  String mESSAGEGROUP;

  NotificationsModel(
      {this.rEASON,
      this.cREATIONTIME,
      this.sUGGESTEDACTION,
      this.aDVISORNAME,
      this.mETRICVALUE,
      this.mESSAGETYPE,
      this.mESSAGEGROUP});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    rEASON = json['REASON'];
    cREATIONTIME = json['CREATION_TIME'];
    sUGGESTEDACTION = json['SUGGESTED_ACTION'];
    aDVISORNAME = json['ADVISOR_NAME'];
    mETRICVALUE = json['METRIC_VALUE'];
    mESSAGETYPE = json['MESSAGE_TYPE'];
    mESSAGEGROUP = json['MESSAGE_GROUP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['REASON'] = this.rEASON;
    data['CREATION_TIME'] = this.cREATIONTIME;
    data['SUGGESTED_ACTION'] = this.sUGGESTEDACTION;
    data['ADVISOR_NAME'] = this.aDVISORNAME;
    data['METRIC_VALUE'] = this.mETRICVALUE;
    data['MESSAGE_TYPE'] = this.mESSAGETYPE;
    data['MESSAGE_GROUP'] = this.mESSAGEGROUP;
    return data;
  }
}
