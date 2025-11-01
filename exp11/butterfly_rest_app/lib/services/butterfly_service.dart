import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/butterfly.dart';

class ButterflyService {
  Future<List<Butterfly>> fetchButterflies() async {
    final url = Uri.parse(
      'https://api.gbif.org/v1/occurrence/search?q=butterfly&mediaType=StillImage',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Butterfly.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load flower data');
    }
  }
}