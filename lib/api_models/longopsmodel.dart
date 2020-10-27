class LongopsModel {
  String sQLID;
  double sID;
  double serial;
  String target;
  String mensagem;
  String text;
  String machine;
  String inicio;
  String fimEstimado;
  double tempoRestante;

  LongopsModel(
      {this.sQLID,
      this.sID,
      this.serial,
      this.target,
      this.mensagem,
      this.text,
      this.machine,
      this.inicio,
      this.fimEstimado,
      this.tempoRestante});

  LongopsModel.fromJson(Map<String, dynamic> json) {
    sQLID = json['SQL ID'];
    sID = json['SID'];
    serial = json['Serial'];
    target = json['Target'];
    mensagem = json['Mensagem'];
    text = json['TEXT'];
    machine = json['MODULE'];
    inicio = json['Inicio'];
    fimEstimado = json['Fim Estimado'];
    tempoRestante = json['Tempo Restante'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SQL ID'] = this.sQLID;
    data['SID'] = this.sID;
    data['Serial'] = this.serial;
    data['Target'] = this.target;
    data['Mensagem'] = this.mensagem;
    data['TEXT'] = this.text;
    data['MODULE'] = this.machine;
    data['Inicio'] = this.inicio;
    data['Fim Estimado'] = this.fimEstimado;
    data['Tempo Restante'] = this.tempoRestante;
    return data;
  }
}
