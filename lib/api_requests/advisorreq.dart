import 'package:dbmonitor/api_models/advisormodel.dart';

import 'baserequest.dart';

class AdvisorRequest extends BaseRequest {
  Future<List<AdvisorModel>> fetchAdvisor({String tipo}) async {
    List retorno = await super.fetch('advisor?tipo=$tipo');

    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return AdvisorModel.fromJson(dado);
    }).toList();
  }
}
