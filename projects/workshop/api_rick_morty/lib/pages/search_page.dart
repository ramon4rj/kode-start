import 'package:flutter/material.dart';
import 'package:api_rick_morty/models/character.dart';
import 'package:api_rick_morty/services/services.dart';
import 'package:api_rick_morty/components/character_detail_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController(); // Controlador de texto usado p/ pesquisar personagens
  List<Character> _searchResults = []; // Lista personagens encontrados
  bool _isLoading = false; // Variáveis booleanas para
  bool _noResults = false; // indicar estado

  Future<void> _performSearch() async {
    if (_searchController.text.isEmpty) return;

    setState(() { // estado interno do widget mudou 
      _isLoading = true;
      _noResults = false;
      _searchResults.clear(); // limpa resultados
    });

    try {
      final result = await ApiService.searchCharacters(_searchController.text); // Busca personagens de acordo como controller
      
      // Atualiza estados com os resultados
      setState(() {
        _searchResults = result['results'] ?? [];
        _noResults = _searchResults.isEmpty;
        _isLoading = false;
      });
    } 
    catch (e) {
      setState(() {
        _isLoading = false; // Atualiza estados em caso de erro
        _noResults = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error on search: ${e.toString()}')),
      );
    }
  }

  // Se livra do controller garantindo descarte de recursos usados pelo objeto
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search characters'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch, // Chama a busca ao clicar na lupa
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (_) => _performSearch(), // Chama a busca ao apertar enter
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  // Exibe os resultados
  Widget _buildSearchResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_noResults) {
      return const Center(
        child: Text('None character found'),
      );
    }

    if (_searchResults.isEmpty) {
      return const Center(
        child: Text('Search for a name...'),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final character = _searchResults[index];
        return ListTile( // widget para exibir: ícone, título e legenda
          leading: CircleAvatar(
            backgroundImage: NetworkImage(character.image),
          ),
          title: Text(character.name),
          subtitle: Text('${character.species} - ${character.status}'),
          onTap: () {
            // Vai p/ tela de detalhes
            Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetailScreen(character: character)));
          },
        );
      },
    );
  }
}