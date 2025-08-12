import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  static const String _filterUrl = 'https://rickandmortyapi.com/api/character/?name=';

  static Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/character'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } 
    else {
      throw Exception('Failed to load characters');
    }
  }
  // Usa o url do episódio, contido em 'character' para fazer uma nova requisição
  // p/ rota dos episódios
  static Future<String> getFirstAppearance(String episodeUrl) async {
  final response = await http.get(Uri.parse(episodeUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['name']; // nome do episódio
  } 
  else {
    throw Exception('Error loading episode');
  }
}

static Future<Map<String, dynamic>> searchCharacters(String name) async {
  final response = await http.get(
    Uri.parse('$_filterUrl$name')
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return {
      'info': data['info'],  // Informações de paginação
      'results': (data['results'] as List).map((json) => Character.fromJson(json)).toList()
    };
  } 
  else if (response.statusCode == 404) {
    return {
      'info': null,
      'results': []  // Retorna lista vazia se não encontrar
    };
  } 
  else {
    throw Exception('Failed to search characters');
  }
}

}
