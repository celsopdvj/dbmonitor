import 'basemodel.dart';

class TopsqlModel extends BaseModel {
  String sqlId;
  String childNumber;
  double execuEs;
  double linhasTot;
  double linhaExec;
  double tempoTot;
  double tempoExec;
  String modulo;
  String sqlText;

  TopsqlModel(
      {this.sqlId,
      this.childNumber,
      this.execuEs,
      this.linhasTot,
      this.linhaExec,
      this.tempoTot,
      this.tempoExec,
      this.modulo,
      this.sqlText});

  TopsqlModel.fromJson(Map<String, dynamic> json) {
    sqlId = json['SQL ID'];
    childNumber = json['Child Number'];
    execuEs = json['Execuções'];
    linhasTot = json['Linhas Tot'];
    linhaExec = json['Linha/Exec'];
    tempoTot = json['Tempo Tot'];
    tempoExec = json['Tempo/Exec'];
    modulo = json['Modulo'];
    sqlText = json['SQL Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SQL ID'] = this.sqlId;
    data['Child Number'] = this.childNumber;
    data['Execuções'] = this.execuEs;
    data['Linhas Tot'] = this.linhasTot;
    data['Linha/Exec'] = this.linhaExec;
    data['Tempo Tot'] = this.tempoTot;
    data['Tempo/Exec'] = this.tempoExec;
    data['Modulo'] = this.modulo;
    data['SQL Text'] = this.sqlText;
    return data;
  }
}
