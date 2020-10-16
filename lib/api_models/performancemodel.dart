class PerformanceModel {
  String sampletime;
  double cpu;
  double bcpu;
  double cpuorawait;
  double scheduler;
  double uio;
  double sio;
  double concurrency;
  double application;
  double commit;
  double configuration;
  double administrative;
  double network;
  double queueing;
  double clust;
  double other;

  PerformanceModel(
      {this.sampletime,
      this.cpu,
      this.bcpu,
      this.cpuorawait,
      this.scheduler,
      this.uio,
      this.sio,
      this.concurrency,
      this.application,
      this.commit,
      this.configuration,
      this.administrative,
      this.network,
      this.queueing,
      this.clust,
      this.other});

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    sampletime = json['SAMPLE_TIME'];
    cpu = json['CPU'];
    bcpu = json['BCPU'];
    cpuorawait = json['CPU_ORA_WAIT'];
    scheduler = json['SCHEDULER'];
    uio = json['UIO'];
    sio = json['SIO'];
    concurrency = json['CONCURRENCY'];
    application = json['APPLICATION'];
    commit = json['COMMIT'];
    configuration = json['CONFIGURATION'];
    administrative = json['ADMINISTRATIVE'];
    network = json['NETWORK'];
    queueing = json['QUEUEING'];
    clust = json['CLUST'];
    other = json['OTHER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SAMPLE_TIME'] = this.sampletime;
    data['CPU'] = this.cpu;
    data['BCPU'] = this.bcpu;
    data['CPU_ORA_WAIT'] = this.cpuorawait;
    data['SCHEDULER'] = this.scheduler;
    data['UIO'] = this.uio;
    data['SIO'] = this.sio;
    data['CONCURRENCY'] = this.concurrency;
    data['APPLICATION'] = this.application;
    data['COMMIT'] = this.commit;
    data['CONFIGURATION'] = this.configuration;
    data['ADMINISTRATIVE'] = this.administrative;
    data['NETWORK'] = this.network;
    data['QUEUEING'] = this.queueing;
    data['CLUST'] = this.clust;
    data['OTHER'] = this.other;
    return data;
  }
}
