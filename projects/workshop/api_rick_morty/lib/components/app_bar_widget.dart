import 'package:flutter/material.dart';
// import 'package:kode_start_imc/theme/app_colors.dart';

class RickMortyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RickMortyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C1B1F), // Sua cor grafite
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              // Ícone esquerdo (opcional)
              Icon(Icons.menu, color: Colors.white), 
              
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Imagem do logo (substitua pelo seu asset)
                    Image.asset(
                      'assets/logo.png', 
                      height: 40, // Ajuste conforme necessário
                    ),
                    SizedBox(height: 8),
                    Text(
                      'RICK AND MORTY API',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        letterSpacing: 16.5, // Ajuste o espaçamento
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
              ),
              
              // Ícone direito (opcional)
              Icon(Icons.search, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120); // Altura personalizada
}