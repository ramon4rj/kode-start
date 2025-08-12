import 'package:api_rick_morty/components/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:api_rick_morty/models/character.dart';
import 'package:api_rick_morty/services/services.dart';
import 'package:api_rick_morty/components/character_detail_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
      ),
      home: const CharactersScreen(),
    );
  }
}

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}
// Cria a lista que irá aguardar os resultados da resposta da API
class _CharactersScreenState extends State<CharactersScreen> {
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = ApiService.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RickMortyAppBar(),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) { // Centraliza o card com Center
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null){
            return Text("No data");
          } else {
            return _buildCharacterGrid(snapshot.data!);
          }
        },
      ),
    );
  }


  Widget _buildCharacterGrid(List<Character> characters) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 16),
    scrollDirection: Axis.vertical,
    itemCount: characters.length,
    itemBuilder: (context, index) {
      final character = characters[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailScreen(character: character),
            ),
          );
        },
      child: Container(
        width: 320, // Largura fixa para cada card
        height: 160,
        margin: const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 10),
        // margin: const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 16), // figma
        decoration: BoxDecoration(
          color: Color(0xFF87A1FA),
          borderRadius: BorderRadius.circular(16),
        ),

        // Exibe os personagens de forma vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do personagem
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                character.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Informações 
              Column( // Centraliza os cards
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft, // Alinha o nome do personagem mais a esquerda do card
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Espaço entre o nome
                    child: Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 14, // 14.5 no figma
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Lato',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
          ],
        ),
      )
      ) ;
    },
  );
}

}
