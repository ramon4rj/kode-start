import 'package:flutter/material.dart';
import 'package:api_rick_morty/models/character.dart';
import 'package:api_rick_morty/components/app_bar_widget.dart';
import 'package:api_rick_morty/services/services.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({required this.character, Key? key})
      : super(key: key);


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: RickMortyAppBar(showBackButton: true,), // Assim que carrega a barra, chama o botão de retorno
      body: Align(
        alignment: Alignment.topCenter, // Alinha o Card para a parte central superior

        child: Container(
          width: 320, // largura fixa do card
          margin: const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 16),
          decoration: BoxDecoration(
            color: Color(0xFF87A1FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
              // Imagem
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  character.image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Informações
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 10),
                child: Column( // Centraliza o card
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14.5,
                        color: Colors.white,
                        fontFamily: 'Lato',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 40),
                    // Status + espécie
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: character.status == 'Alive'
                                ? Colors.green
                                : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${character.status} - ${character.species}',
                             style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5,
                                color: Colors.white,
                                fontFamily: 'Lato',
                              ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                        ),
                        const SizedBox(height: 50), // Espaço entre textos
                      ],
                    ),
                    Text(
                          'Gender: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),

                        Text(
                          character.gender,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 10),

                    // Origem
                        Text(
                          'Origin: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          character.origin,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          'Last Known location: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          character.location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 10),

                        // First Seen
                        Text(
                          'First Seen: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.5,
                            color: Colors.white,
                            fontFamily: 'Lato',
                          ),
                        ),

                        FutureBuilder<String>(
                            future: ApiService.getFirstAppearance(character.episode),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                'Error loading episode',
                                style: TextStyle(color: Colors.red),
                              );
                            }
                            else {
                              return Text(
                                snapshot.data ?? '', // retorna objeto se nao for null
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5,
                                color: Colors.white,
                                fontFamily: 'Lato',
                              ),
                              );
                            }
                          },
                          ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}