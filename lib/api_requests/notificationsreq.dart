import 'package:dbmonitor/api_models/notificationsmodel.dart';
import 'baserequest.dart';

class NotificationsRequest extends BaseRequest {
  Future<List<NotificationsModel>> fetchNotifications() async {
    List retorno = await super.fetch('notifications');

    return retorno.map((el) {
      Map<String, dynamic> dado = el;
      return NotificationsModel.fromJson(dado);
    }).toList();
  }
}
