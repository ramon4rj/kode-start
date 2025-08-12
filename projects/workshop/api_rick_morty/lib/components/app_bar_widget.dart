import 'package:flutter/material.dart';
import 'package:api_rick_morty/pages/search_page.dart';

class RickMortyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; // booleano para voltar à tela inicial
  final VoidCallback? onBackPressed;

  const RickMortyAppBar({
    Key? key,
    this.showBackButton = false,
    this.onBackPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C1B1F),
      child: SafeArea(
        child: Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.only(
            // right: 16,
            bottom: 16, // espaçamento inferior
          ),
          child: Row(
            children: [
              // Ícone esquerdo 
              IconButton(
                icon: Icon(
                // Se estiver em character detail -> volta : se não -> menu
                showBackButton ? Icons.arrow_back : Icons.menu,
                color: Colors.white,
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  
                },
              ),
              
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/logo.png', 
                      // height: 70,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'RICK AND MORTY API',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 3, // 16.5% no figma
                        fontWeight: FontWeight.w500, // w400 no figma
                        // fontFamily: 'Lato',
                        // fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Ícone direito
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                tooltip: 'Search',
                onPressed: () {
                  // Filtro por nome
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                }, 
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(135);
}