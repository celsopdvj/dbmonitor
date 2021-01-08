import 'package:dbmonitor/api_models/topsqlmodel.dart';

import 'baserequest.dart';

class TopsqlRequest extends BaseRequest {
  Future<List<TopsqlModel>> fetchTopsql(
      {int dias = 2, int execucoes = 20}) async {
    List retorno = await super.fetch('topsql?dias=$dias&execucoes=$execucoes');
    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return TopsqlModel.fromJson(dado);
    }).toList();
  }
}
