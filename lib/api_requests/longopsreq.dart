import 'package:dbmonitor/api_models/longopsmodel.dart';
import 'baserequest.dart';

class LongopsRequest extends BaseRequest {
  Future<List<LongopsModel>> fetchLongops() async {
    List retorno = await super.fetch('longops');

    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return LongopsModel.fromJson(dado);
    }).toList();
  }
}
