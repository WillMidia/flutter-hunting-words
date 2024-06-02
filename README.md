# Jogo de Caça-Palavras em flutter

Um jogo de caça-palavras divertido e interativo desenvolvido com Flutter. Este jogo desafia os jogadores a encontrar palavras escondidas em uma grade de letras. O jogo é otimizado para dispositivos móveis, mas também funciona bem em telas maiores.

## Funcionalidades

- **Geração Dinâmica de Grade**: A grade é gerada aleatoriamente com palavras posicionadas horizontal ou verticalmente.
- **Seleção Interativa de Palavras**: Os jogadores podem selecionar palavras arrastando sobre a grade.
- **Destaque Permanente**: Palavras encontradas pelo jogador permanecem destacadas.
- **Descrições das Palavras**: As descrições das palavras são exibidas quando uma palavra é encontrada e podem ser visualizadas novamente clicando na palavra na lista.
- **Design Responsivo**: O jogo foi projetado para ter uma boa aparência tanto em dispositivos móveis quanto em telas maiores.

## Começando

### Pré-requisitos

- [Flutter](https://flutter.dev/docs/get-started/install) (versão 2.0 ou superior)
- Um editor de código como [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)

### Instalação

1. Clone o repositório:
    ```sh
    git clone https://github.com/WillMidia/jogo-de-caca-palavras.git
    ```
2. Navegue até o diretório do projeto:
    ```sh
    cd jogo-de-caca-palavras
    ```
3. Instale as dependências:
    ```sh
    flutter pub get
    ```

### Executando o Aplicativo

Para executar o aplicativo em um emulador ou dispositivo físico, use o seguinte comando:
```sh
flutter run
```

### Construindo o Aplicativo

Para construir o aplicativo para release, use o seguinte comando:
```sh
flutter build apk
```
Isso gerará um arquivo APK no diretório `build/app/outputs/flutter-apk`.

## Estrutura do Projeto

- `lib/main.dart`: O ponto de entrada do aplicativo.
- `lib/game_screen.dart`: Contém a lógica principal do jogo e a interface do usuário.
- `assets/`: Diretório para armazenar recursos como imagens e fontes.

## Como Jogar

1. Inicie o aplicativo.
2. Olhe para a grade de letras e encontre as palavras escondidas.
3. Arraste sobre as letras para selecionar uma palavra.
4. As palavras encontradas serão destacadas permanentemente.
5. Clique nas palavras encontradas na parte inferior para ver suas descrições novamente.

## Personalização

### Adicionando Novas Palavras

Para adicionar novas palavras ao jogo, modifique a lista `palavras` e o mapa `wordDescriptions` em `lib/game_screen.dart`:

```dart
final List<String> palavras = ['FLUTTER', 'DART', 'MOBILE', 'APP', 'NOVAPALAVRA'];
final Map<String, String> wordDescriptions = {
  'FLUTTER': 'Um SDK para desenvolvimento de aplicativos móveis.',
  'DART': 'Uma linguagem de programação otimizada para aplicativos da web.',
  'MOBILE': 'Relacionado a dispositivos móveis.',
  'APP': 'Abreviação de aplicativo.',
  'NOVAPALAVRA': 'Descrição da nova palavra.',
};
```

### Mudando o Tamanho da Grade

Para mudar o tamanho da grade, modifique a variável `gridSize` em `lib/game_screen.dart`:

```dart
final int gridSize = 12; // Exemplo de mudança do tamanho da grade para 12x12
```

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.

### Passos para Contribuir

1. Faça um fork do repositório.
2. Crie uma nova branch (`git checkout -b feature-branch`).
3. Faça suas alterações.
4. Faça o commit de suas alterações (`git commit -m 'Adicionar nova funcionalidade'`).
5. Envie para a branch (`git push origin feature-branch`).
6. Abra um pull request.

## Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

## Agradecimentos

- [Flutter](https://flutter.dev/) - O framework utilizado.
- [Dart](https://dart.dev/) - A linguagem de programação utilizada.

---

Obrigado por conferir este projeto! Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato. Feliz codificação! 🎉

---