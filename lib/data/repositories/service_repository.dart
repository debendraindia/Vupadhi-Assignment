import 'package:http/http.dart' as http;
import 'package:vupadhi/data/models/get_all_service_list_model.dart';

class ServiceRepository {
  Future<List<Datum>> fetchServices() async {
    final url = 'http://citizenservice.vupadhi.com/api/webapi/serviceslist?Name=Welfare Scheme';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final getAllServiceListModel = getAllServiceListModelFromJson(response.body);
        return getAllServiceListModel.data ?? [];
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
