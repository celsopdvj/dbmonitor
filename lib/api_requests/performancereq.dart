import 'package:dbmonitor/api_models/performancemodel.dart';
import 'baserequest.dart';

class PerformanceRequest extends BaseRequest {
  Future<List<PerformanceModel>> fetchPerformance({int minutes = 30}) async {
    List retorno = await super.fetch('graph?minutes=$minutes');

    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return PerformanceModel.fromJson(dado);
    }).toList();
  }
}
