class AdvisorModel {
  double tamanhoGB;
  double fator;
  int tempoEstimado;
  int consistentGets;
  int dBBlockGets;
  int physicalReads;
  double hitRatio;

  AdvisorModel(
      {this.consistentGets,
      this.dBBlockGets,
      this.physicalReads,
      this.hitRatio,
      this.tamanhoGB,
      this.fator,
      this.tempoEstimado});

  AdvisorModel.fromJson(Map<String, dynamic> json) {
    tamanhoGB = json['Tamanho GB'];
    fator = json['Fator'];
    tempoEstimado = json['Tempo Estimado'];
    consistentGets = json['Consistent Gets'];
    dBBlockGets = json['DB Block Gets'];
    physicalReads = json['Physical Reads'];
    hitRatio = json['Hit Ratio %'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tamanho GB'] = this.tamanhoGB;
    data['Fator'] = this.fator;
    data['Tempo Estimado'] = this.tempoEstimado;
    data['Consistent Gets'] = this.consistentGets;
    data['DB Block Gets'] = this.dBBlockGets;
    data['Physical Reads'] = this.physicalReads;
    data['Hit Ratio %'] = this.hitRatio;
    return data;
  }

  dynamic getProp(String key) => <String, dynamic>{
        'tamanhoGB': this.tamanhoGB,
        'fator': this.fator,
        'tempoEstimado': this.tempoEstimado,
        'consistentGets': this.consistentGets,
        'dBBlockGets': this.dBBlockGets,
        'physicalReads': this.physicalReads,
        'hitRatio': this.hitRatio,
      }[key];
}
