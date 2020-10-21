import 'package:dbmonitor/api_models/tablespacemodel.dart';

import 'baserequest.dart';

class TablespaceRequest extends BaseRequest {
  Future<List<TablespaceModel>> fetchTablespace() async {
    List retorno = await super.fetch('tablespaces');

    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return TablespaceModel.fromJson(dado);
    }).toList();
  }
}
