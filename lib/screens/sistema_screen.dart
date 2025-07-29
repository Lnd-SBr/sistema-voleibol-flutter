import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class SistemaScreen extends StatefulWidget {
  final String sistema;

  const SistemaScreen({required this.sistema});

  @override
  _SistemaScreenState createState() => _SistemaScreenState();
}

class _SistemaScreenState extends State<SistemaScreen> {
  int rotacao = 1;
  final FlutterTts flutterTts = FlutterTts();

  late String jogadorSelecionado;

  @override
  void initState() {
    super.initState();

    // Inicializa o jogador selecionado de acordo com o sistema
    jogadorSelecionado = widget.sistema == '5x1' ? 'LEVANTADOR' : 'JOGADOR1';

    // Configurações do flutterTts
    flutterTts.setLanguage("pt-BR");
    flutterTts.setSpeechRate(0.6);
  }



  final List<String> jogadores5x1 = [

    'LEVANTADOR',
    'PONTEIRO1',
    'PONTEIRO2',
    'CENTRAL1',
    'CENTRAL2',
    'OPOSTO' ,
    'LIBERO'
  ];

  final List<String> jogadores6x0 = [
    'JOGADOR1',
    'JOGADOR2',
    'JOGADOR3',
    'JOGADOR4',
    'JOGADOR5',
    'JOGADOR6' ,
  ];


  String get imagemAtual {
    final nomeJogador = jogadorSelecionado.toLowerCase();

    if (widget.sistema == '5x1') {
      return 'assets/$nomeJogador/${nomeJogador}_p$rotacao.png';
    } else if (widget.sistema == '6x0') {
      return 'assets/6x0/${nomeJogador}_p$rotacao.png';
    } else {
      return ''; // suporte futuro para outros sistemas
    }
  }


  String get imagemQuadraAtual {
    return 'assets/quadra/quadra_p$rotacao.png';
  }

  final Map<String, Map<int, String>> explicacoesPorJogador = {
    'LEVANTADOR': {
      1: 'Levantador na posição 1, no fundo da quadra, atento à cobertura e preparado para deslocamento ofensivo.',
      2: 'Levantador na posição 2, adiantado na rede, pronto para distribuir jogadas rápidas.',
      3: 'Levantador na posição 3, em posição central para armar ataques variados.',
      4: 'Levantador na posição 4, realizando cobertura de rede e ajustando posicionamento.',
      5: 'Levantador na posição 5, deslocando-se para frente após o saque.',
      6: 'Levantador na posição 6, recuado na defesa e já visualizando transição para o levantamento.'
    },
    'OPOSTO': {
      1: 'Oposto na posição 1, colaborando com a defesa e se preparando para a próxima rotação ofensiva.',
      2: 'Oposto na posição 2, pronto para o ataque pela saída de rede e bloqueio.',
      3: 'Oposto na posição 3, ajudando no bloqueio central e cobertura de bola rápida.',
      4: 'Oposto na posição 4, se ajustando para o deslocamento defensivo após saque.',
      5: 'Oposto na posição 5, recuado na defesa lateral da quadra.',
      6: 'Oposto na posição 6, atento à cobertura e preparando-se para avançar à rede.'
    },
    'PONTEIRO1': {
      1: 'Ponteiro 1 na posição 1, atuando na defesa do fundo e cobertura de bolas curtas.',
      2: 'Ponteiro 1 na posição 2, já posicionado para ataques rápidos pela entrada da rede.',
      3: 'Ponteiro 1 na posição 3, auxiliando no bloqueio e cobertura ofensiva.',
      4: 'Ponteiro 1 na posição 4, sua principal zona de ataque pela entrada.',
      5: 'Ponteiro 1 na posição 5, responsável pela recepção e ajuste de passe.',
      6: 'Ponteiro 1 na posição 6, defendendo a parte central do fundo da quadra.'
    },
    'PONTEIRO2': {
      1: 'Ponteiro 2 na posição 1, ajudando na defesa e cobertura de bolas longas.',
      2: 'Ponteiro 2 na posição 2, pronto para o ataque pela ponta da rede.',
      3: 'Ponteiro 2 na posição 3, contribuindo com o bloqueio e cobertura.',
      4: 'Ponteiro 2 na posição 4, atuando como atacante principal da entrada.',
      5: 'Ponteiro 2 na posição 5, em transição para a recepção do saque.',
      6: 'Ponteiro 2 na posição 6, ajustando o posicionamento defensivo central.'
    },
    'CENTRAL1': {
      1: 'Central 1 na posição 1, ajudando na cobertura do fundo e se preparando para rotação ofensiva.',
      2: 'Central 1 na posição 2, atuando no bloqueio e ataque de bolas rápidas.',
      3: 'Central 1 na posição 3, em posição ideal para ataque tempo 1 e bloqueio central.',
      4: 'Central 1 na posição 4, em transição defensiva e ajustando posicionamento.',
      5: 'Central 1 na posição 5, recuado e se preparando para subir à rede.',
      6: 'Central 1 na posição 6, cobrindo a defesa do meio da quadra.'
    },
    'CENTRAL2': {
      1: 'Central 2 na posição 1, atuando na defesa e se preparando para rotação à frente.',
      2: 'Central 2 na posição 2, ajustando para bloqueio e ataque rápido.',
      3: 'Central 2 na posição 3, principal zona de ação para ataques rápidos.',
      4: 'Central 2 na posição 4, ajudando no bloqueio lateral e movimentação ofensiva.',
      5: 'Central 2 na posição 5, recuado após rotação, em cobertura de fundo.',
      6: 'Central 2 na posição 6, cobrindo a defesa e visualizando transição ofensiva.'
    },
    'LIBERO': {
      1: 'Líbero na posição 1, atuando na defesa e se preparando para rotação à frente.',
      2: 'Líbero na posição 2, No momento em que o líbero iria para P2 ele na verdade já está no fundo no lugar do central. Isso ocorre porque o líbero não pode ocupar as posições de ataque na quadra (4, 3 e 2).',
      3: 'Líbero na posição 3, principal zona de ação para ataques rápidos.',
      4: 'Líbero na posição 4, ajudando no bloqueio lateral e movimentação ofensiva.',
      5: 'Líbero na posição 5, recuado após rotação, em cobertura de fundo.',
      6: 'Líbero na posição 6, cobrindo a defesa e visualizando transição ofensiva.'

    }
  };

  void narrarTextoExplicativo() {
    final texto = explicacoesPorJogador[jogadorSelecionado.toUpperCase()]?[rotacao] ?? '';
    flutterTts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posição $rotacao - Sistema ${widget.sistema}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: jogadorSelecionado,
              onChanged: (String? novoValor) {
                setState(() {
                  jogadorSelecionado = novoValor!;
                });
              },
              items: (widget.sistema == '5x1' ? jogadores5x1 : jogadores6x0)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (widget.sistema != '5x1' && widget.sistema != '6x0')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'O sistema "${widget.sistema}" ainda não está disponível.\nEm breve você poderá explorá-lo!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          else

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(imagemAtual, fit: BoxFit.contain),
                    const SizedBox(height: 12),
                    Text(
                      'Referência da Posição na Quadra',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      imagemQuadraAtual,
                      height: 230,
                      fit: BoxFit.contain,
                    ),

                    // Botões de rotação
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 4,
                      alignment: WrapAlignment.center,
                      children: List.generate(6, (index) {
                        final numero = index + 1;
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              rotacao = numero;
                            });
                          },
                          child: Text('P$numero'),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),

                    // Texto explicativo com moldura
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Container(
                          key: ValueKey('$jogadorSelecionado-$rotacao'),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800, // Agora com melhor contraste
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),

                          child: Text(
                            explicacoesPorJogador[jogadorSelecionado.toUpperCase()]?[rotacao] ?? '',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.volume_up, color: Colors.white),
                            onPressed: narrarTextoExplicativo,
                            tooltip: 'Ouvir explicação',
                          ),
                          IconButton(
                            icon: Icon(Icons.play_circle_fill, color: Colors.white),
                            onPressed: () {
                              // Em breve: tocar vídeo
                            },
                            tooltip: 'Ver animação (em breve)',
                          ),
                          IconButton(
                            icon: Icon(Icons.note, color: Colors.white),
                            onPressed: () {
                              // Em breve: abrir anotações
                            },
                            tooltip: 'Minhas anotações (em breve)',
                          ),
                          IconButton(
                            icon: Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              // Em breve: compartilhar
                            },
                            tooltip: 'Compartilhar (em breve)',
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline, color: Colors.white),
                            onPressed: () {
                              // Em breve: ajuda
                            },
                            tooltip: 'Ajuda rápida (em breve)',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
