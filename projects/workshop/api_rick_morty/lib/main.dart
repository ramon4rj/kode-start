import 'package:api_rick_morty/components/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:api_rick_morty/models/character.dart';
import 'package:api_rick_morty/services/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
        // scaffoldBackgroundColor: Color(0xFF1C1B1F)
        // appBarTheme: AppBarTheme(
        //   backgroundColor: Color(0xFF1C1B1F),
        //   foregroundColor: Colors.white,
        //   toolbarHeight: 130.92,
        //   centerTitle: true,
        //   titleTextStyle: TextStyle(
        //     color: Colors.white, 
        //     fontSize: 14.5,
        //     letterSpacing: 16.5,
        //     fontWeight: FontWeight.w400,
        //     fontFamily: 'Lato'
        //   ),
        // )
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
      return Container(
        width: 320, // Largura fixa para cada card
        height: 160,
        // margin: const EdgeInsets.only(right: 25, left: 25, top: 8, bottom: 8),
        margin: const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 16),
        decoration: BoxDecoration(
          // color: Colors.grey[900],
          color: Color(0xFF87A1FA),
          borderRadius: BorderRadius.circular(16),
        ),
        // Padding interno
        // padding: const EdgeInsets.all(16),

        // Exibe os personagens de forma vertical
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column( // Centraliza os cards
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Nome (uma linha com ellipsis se for muito longo)
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 14, // usar 14.5 da overflow by pixels
                      // fontWeight: FontWeight.w900,
                      fontFamily: 'Lato',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

}

