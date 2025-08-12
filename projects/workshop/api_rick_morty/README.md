<h1 align="center">Api Rick and Morty </h1>


API criada para exercitar conhecimentos em Flutter na API Rick and Morty

Informações coletadas:

- Name
- Status
- Species
- Gender
- Origin
- Last known Location
- First Seen

## 📦 Arquitetura do Projeto

Estrutura de diretórios
```
lib/
├── components/  # Componentes das telas
├── models/      # Modelos de dados
├── pages/       # Páginas usadas
├── services/    # Serviços de API e repositórios
└── main.dart    # Arquivo principal
```

## Padrões Adotados

- Arquitetura Clean Simplificada: Separação entre camadas de apresentação, dados e serviços


## 💻 Tecnologias Utilizadas

- Flutter 3.32.8
- Dart 3.8.1
 

## 🛠️ Funcionalidades Implementadas

// Incluir Gifs ou videos 

1. Paginação de Personagens
- Mostra lista de personagens

![vid1](https://github.com/ramon4rj/kode-start/blob/develop/projects/workshop/api_rick_morty/assets/vid1.gif)

2. Informações de Personagens
- Mostra infomações sobre o personagem


![vid2](https://github.com/ramon4rj/kode-start/blob/develop/projects/workshop/api_rick_morty/assets/vid2.gif)

3. Busca de Personagens
- Busca personagens por nome parcial ou completo


![vid3](https://github.com/ramon4rj/kode-start/blob/develop/projects/workshop/api_rick_morty/assets/vid3.gif)

4. Navegação Entre Telas
- Navegação entre tela inicial, informação e busca


![vid4](https://github.com/ramon4rj/kode-start/blob/develop/projects/workshop/api_rick_morty/assets/vid4.gif)

## 📋 Pré-Requisitos
- Android Studio
- Android SDK Build-Tools
- NDK (Side by side)
- Android SDK Plataform-Tools


## 🔧 Como Executar
```
# Instale o Dart e o Flutter
sudo snap install dart --classic
sudo snap install flutter --classic

# Clone o repositório
git clone https://github.com/ramon4rj/kode-start.git

# Acesse a pasta da API
cd projects/workshop/api_rick_morty

# Instale as dependências
sudo apt update -y && sudo apt-get upgrade -y;
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa
sudo apt install libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64
sudo apt install clang cmake ninja-build pkg-config libgtk-3-dev


# Teste para ver se falta alguma coisa
flutter doctor

# Crie a plataforma
flutter create --plataforms=android .

# Detecte o dispositivo android
flutter devices

# Rode o projeto 
flutter run -d <id do dispositivo>

```
