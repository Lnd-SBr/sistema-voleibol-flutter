import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';

class SistemaScreen extends StatefulWidget {
  final String sistema;

  const SistemaScreen({super.key, required this.sistema});

  @override
  SistemaScreenState createState() => SistemaScreenState();
}

class SistemaScreenState extends State<SistemaScreen> {
  int rotacao = 1;
  final FlutterTts flutterTts = FlutterTts();

  late String jogadorSelecionado;
  late VideoPlayerController _videoController;
  bool _isVideoVisible = false; // controlar se o player está visível
  String? _currentVideoPath; // guarda o vídeo atualmente carregado (evita reload desnecessário)

  /// Resonator o caminho do vídeo com base no sistema e no jogador selecionado
  String? _getVideoPath() {
    if (widget.sistema == '5x1') {
      if (jogadorSelecionado == 'LEVANTADOR') {
        return 'assets/videos/levantador5x1.mp4';
      } else if (jogadorSelecionado == 'OPOSTO') {
        return 'assets/videos/oposto5x1.mp4';
      } else if (jogadorSelecionado == 'LIBERO') {
        return 'assets/videos/libero5x1.mp4';
      } else if (jogadorSelecionado == 'CENTRAL1') {
        return 'assets/videos/central15x1.mp4';
      } else if (jogadorSelecionado == 'CENTRAL2') {
        return 'assets/videos/central25x1.mp4';
      } else if (jogadorSelecionado == 'PONTEIRO1') {
        return 'assets/videos/ponteiro15x1.mp4';
      } else if (jogadorSelecionado == 'PONTEIRO2') {
        return 'assets/videos/ponteiro25x1.mp4';
      }
    }
    return null; // caso não tenha vídeo para esse jogador/sistema
  }


  /// Inicializa e toca o vídeo correto
  Future<void> _playVideo() async {
    final path = _getVideoPath();
    if (path == null) return;

    // Se já estiver reproduzindo outro vídeo, fecha
    if (_isVideoVisible && _currentVideoPath != path) {
      _videoController.pause();
      _videoController.dispose();
    }

    _videoController = VideoPlayerController.asset(path);
    await _videoController.initialize();

    setState(() {
      _currentVideoPath = path;
      _isVideoVisible = true;
      _videoController.play();
    });
  }


  @override
  void initState() {
    super.initState();

    // Inicializa o jogador selecionado de acordo com o sistema
    switch (widget.sistema) {
      case '5x1':
        jogadorSelecionado = 'LEVANTADOR';
        break;
      case '6x0':
        jogadorSelecionado = 'JOGADOR1';
        break;
      case '4x2':
        jogadorSelecionado = 'LEVANTADOR1';
        break;
      case '4x2 Invertido':
        jogadorSelecionado = 'LEVANTADOR1';
        break;
      default:
        jogadorSelecionado = 'JOGADOR1'; // ou outro valor padrão
    }

    // Configurações do flutterTts
    flutterTts.setLanguage('pt-BR');
    flutterTts.setSpeechRate(0.6);

    // Video player
    if (widget.sistema == '5x1') {
      _videoController = VideoPlayerController.asset('assets/videos/levantador5x1.mp4')
        ..initialize().then((_) {
          setState(() {}); // rebuild para mostrar vídeo
        });
    }
  }

  @override
  void dispose() {
    flutterTts.stop();

    if (widget.sistema == '5x1') {
      _videoController.dispose();
    }

    super.dispose();
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

  final List<String> jogadores4x2 = [
    'LEVANTADOR1',
    'LEVANTADOR2',
    'PONTEIRO1',
    'PONTEIRO2',
    'PONTEIRO3',
    'PONTEIRO4' ,
  ];

  final List<String> jogadores4x2I = [
    'LEVANTADOR1',
    'LEVANTADOR2',
    'PONTEIRO1',
    'PONTEIRO2',
    'PONTEIRO3',
    'PONTEIRO4' ,
  ];


  String get imagemAtual {
    final nomeJogador = jogadorSelecionado.toLowerCase();

    if (widget.sistema == '5x1') {
      return 'assets/5x1/${nomeJogador}_p$rotacao.png';
    } else if (widget.sistema == '6x0') {
      return 'assets/6x0/${nomeJogador}_p$rotacao.png';
    } else if (widget.sistema == '4x2') {
      return 'assets/4x2/${nomeJogador}_p$rotacao.png';
    } else if (widget.sistema == '4x2 Invertido') {
      return 'assets/4x2i/${nomeJogador}_p$rotacao.png';
    } else {
      return ''; // suporte futuro para outros sistemas
    }
  }



  String get imagemQuadraAtual {
    return 'assets/quadra/quadra_p$rotacao.png';
  }

  final Map<String, Map<String, Map<int, String>>> explicacoesPorSistema = {
    // ================= 5x1 =================
    '5x1': {
      'LEVANTADOR': {
        1: 'Levantador na posição 1, fundo direito. Atua na defesa e cobertura, pronto para se deslocar até a rede para armar a jogada. Mesmo distante, deve manter visão de bloqueio adversário e preparar a distribuição das bolas.',
        2: 'Levantador na posição 2, frente direita. Próximo à rede, assume total controle ofensivo, decidindo entre bolas rápidas pelo meio, ataques de ponta ou saída. Também participa do bloqueio contra o ponteiro adversário.',
        3: 'Levantador na posição 3, centro da rede. Posicionado no meio, tem acesso ideal a todos os atacantes. Sua função é variar a distribuição, explorando jogadas rápidas pelo central e mantendo imprevisibilidade ofensiva.',
        4: 'Levantador na posição 4, frente esquerda. Deixa de atuar como atacante para focar na armação. Comanda a distribuição a partir da ponta, buscando precisão em bolas rápidas de meio, ataques de saída e inversões.',
        5: 'Levantador na posição 5, fundo esquerdo. Atua principalmente na defesa e cobertura de ataques, mas deve manter prontidão para deslocar-se rapidamente até a rede, garantindo continuidade do sistema ofensivo.',
        6: 'Levantador na posição 6, fundo central. Participa ativamente da defesa e leitura de jogo. Após a recepção ou defesa, desloca-se para organizar a jogada, priorizando ataques de saída ou bolas rápidas pelo meio.'
      },
      'PONTEIRO1': {
        1: 'Ponteiro na posição 1, fundo direito. Participa da recepção em conjunto com líbero e oposto. Atua na defesa de bolas cruzadas e prepara-se para transição rápida ao ataque pela entrada de rede.',
        2: 'Ponteiro na posição 2, frente direita. Embora menos comum como atacante principal nesta zona, participa do bloqueio lateral e serve como alternativa ofensiva em bolas altas ou ajustes de levantamento.',
        3: 'Ponteiro na posição 3, centro da rede. Eventualmente apoia bloqueio central e se prepara para cobertura. Atua como opção secundária em bolas rápidas ou combinações ofensivas quando necessário.',
        4: 'Ponteiro na posição 4, frente esquerda. Principal referência de ataque de entrada, recebe a maioria das bolas altas e de segurança. Também atua no bloqueio contra o oposto adversário, sendo peça-chave ofensiva.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Um dos principais responsáveis pelo passe, cobre grande parte da quadra na recepção. Após o passe, prepara-se para ataque pipe ou transição pela ponta.',
        6: 'Ponteiro na posição 6, fundo central. Atua fortemente na defesa e cobertura, com leitura rápida do ataque adversário. Em situações de contra-ataque, é opção de ataque pipe ou apoio à construção ofensiva.'
      },
      'PONTEIRO2': {
        1: 'Ponteiro na posição 1, fundo direito. Participa da recepção em conjunto com líbero e oposto. Atua na defesa de bolas cruzadas e prepara-se para transição rápida ao ataque pela entrada de rede.',
        2: 'Ponteiro na posição 2, frente direita. Embora menos comum como atacante principal nesta zona, participa do bloqueio lateral e serve como alternativa ofensiva em bolas altas ou ajustes de levantamento.',
        3: 'Ponteiro na posição 3, centro da rede. Eventualmente apoia bloqueio central e se prepara para cobertura. Atua como opção secundária em bolas rápidas ou combinações ofensivas quando necessário.',
        4: 'Ponteiro na posição 4, frente esquerda. Principal referência de ataque de entrada, recebe a maioria das bolas altas e de segurança. Também atua no bloqueio contra o oposto adversário, sendo peça-chave ofensiva.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Um dos principais responsáveis pelo passe, cobre grande parte da quadra na recepção. Após o passe, prepara-se para ataque pipe ou transição pela ponta.',
        6: 'Ponteiro na posição 6, fundo central. Atua fortemente na defesa e cobertura, com leitura rápida do ataque adversário. Em situações de contra-ataque, é opção de ataque pipe ou apoio à construção ofensiva.'

      },
      'CENTRAL1': {
        1: 'Central na posição 1, fundo direito. Atua prioritariamente na defesa, cobrindo bolas rápidas e iniciando a transição para ataque. Permanece atento para recompor no bloqueio quando avançar à rede.',
        2: 'Central na posição 2, frente direita. Participa ativamente do bloqueio contra o ponteiro adversário e pode ser utilizado em combinações rápidas como "china" ou bolas de tempo com o levantador.',
        3: 'Central na posição 3, centro da rede. Principal referência para ataques rápidos de meio, busca variações como tempo A e B. Responsável por fechar o bloqueio central e coordenar coberturas defensivas.',
        4: 'Central na posição 4, frente esquerda. Apoia o bloqueio contra o ponteiro adversário, atua em movimentações de cobertura lateral e serve como opção de ataque em deslocamento rápido do meio para a ponta.',
        5: 'Central na posição 5, fundo esquerdo. Atua na defesa e cobertura, participando da recepção quando necessário. Prepara-se para transição rápida ao ataque, especialmente em combinações de fundo.',
        6: 'Central na posição 6, fundo central. Tem papel chave na defesa contra ataques do meio adversário. Acompanha jogadas rápidas e, em contra-ataques, pode ser utilizado em ataques pipe ou deslocamento acelerado.'
      },
      'CENTRAL2': {
        1: 'Central na posição 1, fundo direito. Atua prioritariamente na defesa, cobrindo bolas rápidas e iniciando a transição para ataque. Permanece atento para recompor no bloqueio quando avançar à rede.',
        2: 'Central na posição 2, frente direita. Participa ativamente do bloqueio contra o ponteiro adversário e pode ser utilizado em combinações rápidas como "china" ou bolas de tempo com o levantador.',
        3: 'Central na posição 3, centro da rede. Principal referência para ataques rápidos de meio, busca variações como tempo A e B. Responsável por fechar o bloqueio central e coordenar coberturas defensivas.',
        4: 'Central na posição 4, frente esquerda. Apoia o bloqueio contra o ponteiro adversário, atua em movimentações de cobertura lateral e serve como opção de ataque em deslocamento rápido do meio para a ponta.',
        5: 'Central na posição 5, fundo esquerdo. Atua na defesa e cobertura, participando da recepção quando necessário. Prepara-se para transição rápida ao ataque, especialmente em combinações de fundo.',
        6: 'Central na posição 6, fundo central. Tem papel chave na defesa contra ataques do meio adversário. Acompanha jogadas rápidas e, em contra-ataques, pode ser utilizado em ataques pipe ou deslocamento acelerado.'
      },
      'OPOSTO': {
        1: 'Oposto na posição 1, fundo direito. Não participa da recepção, mas posiciona-se atrás do líbero e já se prepara para a transição rápida em ataques de saída pela diagonal ou fundo. Também deve estar atento à cobertura defensiva.',
        2: 'Oposto na posição 2, frente direita na rede. É o principal atacante de bolas altas ou rápidas na saída e tem papel essencial no bloqueio contra o ponteiro adversário. Sua função é garantir opção constante de ataque mesmo em passes afastados.',
        3: 'Oposto na posição 3, zona central da rede. Participa ativamente do bloqueio no meio e deve estar preparado para combinações rápidas. Embora não seja atacante central, mantém disponibilidade para ataque de saída em bolas altas.',
        4: 'Oposto na posição 4, frente esquerda. Apesar de não ser sua zona natural de ataque, participa do bloqueio contra o oposto adversário e auxilia em coberturas. Pode ser utilizado em jogadas de fundo ou para desafogar quando necessário.',
        5: 'Oposto na posição 5, fundo esquerdo. Não participa diretamente da recepção, mas é responsável por cobrir a defesa nesta zona e preparar a transição ofensiva para ataques de saída. Deve manter-se pronto para contra-ataques rápidos.',
        6: 'Oposto na posição 6, fundo central. Focado em defesa de ataques adversários e coberturas de bloqueio. Após a defesa, faz transição rápida para o ataque pela saída, sendo opção segura para o levantador em bolas de contra-ataque.'
      },
      'LIBERO': {
        1: 'Líbero na posição 1, fundo direito. Atua na defesa de bolas diagonais longas e na cobertura do oposto. É peça chave na transição da defesa para o passe, garantindo estabilidade ao sistema.',
        2: 'Líbero na posição 2 não atua, pois a regra impede sua participação na linha de frente. O jogador do fundo entra em seu lugar caso necessário.',
        3: 'Líbero na posição 3 não atua, respeitando as regras que o impedem de ocupar posições de ataque na rede. Permanece preparado para substituição estratégica no fundo.',
        4: 'Líbero na posição 4 não atua. A equipe mantém ponteiro ou outro jogador ofensivo na linha de frente, enquanto o líbero permanece responsável pelas coberturas no fundo.',
        5: 'Líbero na posição 5, fundo esquerdo. É responsável pela recepção de saques e defesas cruzadas. Trabalha em conjunto com o ponteiro passador para organizar a linha de passe.',
        6: 'Líbero na posição 6, fundo central. Comanda a defesa do fundo, sendo responsável por bolas rápidas e coberturas centrais. Atua como principal elo entre defesa e levantador no início da transição ofensiva.'
      },
    },

    // ================= 6x0 =================
    '6x0': {
      'JOGADOR1': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
      'JOGADOR2': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
      'JOGADOR3': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
      'JOGADOR4': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
      'JOGADOR5': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
      'JOGADOR6': {
        1: 'Jogador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção de saques. Deve se preparar para ataque de fundo pela saída, mantendo equilíbrio na cobertura defensiva.',
        2: 'Jogador na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Jogador na posição 3, central na rede. Responsável pelo levantamento no sistema 6x0. Além de organizar o ataque, pode auxiliar no bloqueio central caso a jogada permita.',
        4: 'Jogador na posição 4, rede esquerda. Atua como ponteiro, recebendo bolas abertas para ataque lateral. Também participa do bloqueio contra o oposto adversário.',
        5: 'Jogador na posição 5, fundo esquerdo. Atua na recepção e na defesa cruzada. Contribui na transição do passe para o ataque e pode preparar-se para ataque de fundo pela entrada.',
        6: 'Jogador na posição 6, fundo central. É o principal defensor do fundo de quadra, cobrindo bolas rápidas e ataques diagonais. Também pode iniciar contra-ataques de fundo quando solicitado'

      },
    },

    // ================= 4x2 =================
    '4x2': {
      'LEVANTADOR1': {
        1: 'Levantador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção, mas deve se preparar para organizar o ataque se a bola for direcionada. Apoia a cobertura defensiva.',
        2: 'Levantador na posição 2, rede direita. Principal responsável pela armação do ataque, distribuindo bolas rápidas, abertas e de fundo. Também participa do bloqueio contra o ponteiro adversário.',
        3: 'Levantador na posição 3, central na rede. Pode auxiliar no bloqueio e cobertura de jogadas rápidas, mas sua principal função é estar disponível para levantar quando a jogada exigir.',
        4: 'Levantador na posição 4, rede esquerda. Responsável pela armação de jogadas e distribuição de bolas nesta posição. Atua no bloqueio lateral e pode participar de jogadas de ataque surpresa.',
        5: 'Levantador na posição 5, fundo esquerdo. Atua na recepção e defesa de ataques cruzados. Se a jogada permitir, pode organizar o levantamento de fundo.',
        6: 'Levantador na posição 6, fundo central. Principal responsável pela defesa no meio do fundo e cobertura de ataques adversários. Pode iniciar levantamentos de fundo quando necessário'
      },
      'LEVANTADOR2': {
        1: 'Levantador na posição 1, fundo direito. Atua prioritariamente na defesa e recepção, mas deve se preparar para organizar o ataque se a bola for direcionada. Apoia a cobertura defensiva.',
        2: 'Levantador na posição 2, rede direita. Principal responsável pela armação do ataque, distribuindo bolas rápidas, abertas e de fundo. Também participa do bloqueio contra o ponteiro adversário.',
        3: 'Levantador na posição 3, central na rede. Pode auxiliar no bloqueio e cobertura de jogadas rápidas, mas sua principal função é estar disponível para levantar quando a jogada exigir.',
        4: 'Levantador na posição 4, rede esquerda. Responsável pela armação de jogadas e distribuição de bolas nesta posição. Atua no bloqueio lateral e pode participar de jogadas de ataque surpresa.',
        5: 'Levantador na posição 5, fundo esquerdo. Atua na recepção e defesa de ataques cruzados. Se a jogada permitir, pode organizar o levantamento de fundo.',
        6: 'Levantador na posição 6, fundo central. Principal responsável pela defesa no meio do fundo e cobertura de ataques adversários. Pode iniciar levantamentos de fundo quando necessário'
      },
      'PONTEIRO1': {
        1: 'Ponteiro na posição 1, fundo direito. Contribui na recepção e defesa de bolas profundas, preparando-se também para ataques de fundo pela entrada.',
        2: 'Ponteiro na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Ponteiro na posição 3, central na rede. Apoia no bloqueio e pode participar de ataques rápidos, mas seu foco é auxiliar a cobertura e preparar-se para a rotação ofensiva seguinte.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e realizando ataques laterais. Também atua no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, com preparação para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa, cobrindo diagonais longas. Também pode preparar contra-ataques de fundo, servindo de apoio ao levantador'

      },
      'PONTEIRO2': {
        1: 'Ponteiro na posição 1, fundo direito. Contribui na recepção e defesa de bolas profundas, preparando-se também para ataques de fundo pela entrada.',
        2: 'Ponteiro na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Ponteiro na posição 3, central na rede. Apoia no bloqueio e pode participar de ataques rápidos, mas seu foco é auxiliar a cobertura e preparar-se para a rotação ofensiva seguinte.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e realizando ataques laterais. Também atua no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, com preparação para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa, cobrindo diagonais longas. Também pode preparar contra-ataques de fundo, servindo de apoio ao levantador'

      },
      'PONTEIRO3': {
        1: 'Ponteiro na posição 1, fundo direito. Contribui na recepção e defesa de bolas profundas, preparando-se também para ataques de fundo pela entrada.',
        2: 'Ponteiro na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Ponteiro na posição 3, central na rede. Apoia no bloqueio e pode participar de ataques rápidos, mas seu foco é auxiliar a cobertura e preparar-se para a rotação ofensiva seguinte.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e realizando ataques laterais. Também atua no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, com preparação para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa, cobrindo diagonais longas. Também pode preparar contra-ataques de fundo, servindo de apoio ao levantador'

      },
      'PONTEIRO4': {
        1: 'Ponteiro na posição 1, fundo direito. Contribui na recepção e defesa de bolas profundas, preparando-se também para ataques de fundo pela entrada.',
        2: 'Ponteiro na posição 2, rede direita. Atua como atacante de saída e participa do bloqueio contra o ponteiro adversário. Sua função ofensiva é decisiva nesta posição.',
        3: 'Ponteiro na posição 3, central na rede. Apoia no bloqueio e pode participar de ataques rápidos, mas seu foco é auxiliar a cobertura e preparar-se para a rotação ofensiva seguinte.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e realizando ataques laterais. Também atua no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, com preparação para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa, cobrindo diagonais longas. Também pode preparar contra-ataques de fundo, servindo de apoio ao levantador'

      },
    },
    // ================= 4x2 com infiltração =================
    '4x2 Invertido': {
      'LEVANTADOR1': {
        1: 'Levantador na posição 1, fundo direito. Infiltra pela lateral direita após a recepção para chegar à rede e armar o ataque. Também cobre a defesa no fundo antes da infiltração.',
        2: 'Levantador na posição 2, rede direita. Principal responsável pela armação do ataque, distribuindo bolas rápidas, abertas e combinações. Atua também no bloqueio contra o ponteiro adversário.',
        3: 'Levantador na posição 3, central na rede. Pode auxiliar no bloqueio e na cobertura de ataques rápidos, mas mantém-se atento para realizar o levantamento se necessário.',
        4: 'Levantador na posição 4, rede esquerda. Responsável por distribuir jogadas da entrada e bolas rápidas para o central. Atua também no bloqueio contra o oposto adversário.',
        5: 'Levantador na posição 5, fundo esquerdo. Infiltra pelo fundo após a recepção para armar o ataque. Antes da infiltração, atua na defesa e cobertura de ataques cruzados.',
        6: 'Levantador na posição 6, fundo central. Infiltra pelo meio após a recepção para organizar a armação, cobrindo inicialmente a defesa no fundo central'

      },
      'LEVANTADOR2': {
        1: 'Levantador na posição 1, fundo direito. Infiltra pela lateral direita após a recepção para chegar à rede e armar o ataque. Também cobre a defesa no fundo antes da infiltração.',
        2: 'Levantador na posição 2, rede direita. Principal responsável pela armação do ataque, distribuindo bolas rápidas, abertas e combinações. Atua também no bloqueio contra o ponteiro adversário.',
        3: 'Levantador na posição 3, central na rede. Pode auxiliar no bloqueio e na cobertura de ataques rápidos, mas mantém-se atento para realizar o levantamento se necessário.',
        4: 'Levantador na posição 4, rede esquerda. Responsável por distribuir jogadas da entrada e bolas rápidas para o central. Atua também no bloqueio contra o oposto adversário.',
        5: 'Levantador na posição 5, fundo esquerdo. Infiltra pelo fundo após a recepção para armar o ataque. Antes da infiltração, atua na defesa e cobertura de ataques cruzados.',
        6: 'Levantador na posição 6, fundo central. Infiltra pelo meio após a recepção para organizar a armação, cobrindo inicialmente a defesa no fundo central'

      },
      'PONTEIRO1': {
        1: 'Ponteiro na posição 1, fundo direito. Atua na recepção e defesa, podendo também preparar ataques de fundo pela entrada após a armação.',
        2: 'Ponteiro na posição 2, rede direita. Pode atuar como atacante de saída quando o levantador infiltra do fundo. Participa também do bloqueio lateral.',
        3: 'Ponteiro na posição 3, central na rede. Auxilia no bloqueio e pode ser opção de ataque em jogadas rápidas pelo meio, mas mantém foco na cobertura.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e diagonais. Atua também no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, preparando-se para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa de diagonais longas e pode ser opção em contra-ataques de fundo, apoiando a armação'

      },
      'PONTEIRO2': {
        1: 'Ponteiro na posição 1, fundo direito. Atua na recepção e defesa, podendo também preparar ataques de fundo pela entrada após a armação.',
        2: 'Ponteiro na posição 2, rede direita. Pode atuar como atacante de saída quando o levantador infiltra do fundo. Participa também do bloqueio lateral.',
        3: 'Ponteiro na posição 3, central na rede. Auxilia no bloqueio e pode ser opção de ataque em jogadas rápidas pelo meio, mas mantém foco na cobertura.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e diagonais. Atua também no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, preparando-se para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa de diagonais longas e pode ser opção em contra-ataques de fundo, apoiando a armação'

      },
      'PONTEIRO3': {
        1: 'Ponteiro na posição 1, fundo direito. Atua na recepção e defesa, podendo também preparar ataques de fundo pela entrada após a armação.',
        2: 'Ponteiro na posição 2, rede direita. Pode atuar como atacante de saída quando o levantador infiltra do fundo. Participa também do bloqueio lateral.',
        3: 'Ponteiro na posição 3, central na rede. Auxilia no bloqueio e pode ser opção de ataque em jogadas rápidas pelo meio, mas mantém foco na cobertura.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e diagonais. Atua também no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, preparando-se para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa de diagonais longas e pode ser opção em contra-ataques de fundo, apoiando a armação'

      },
      'PONTEIRO4': {
        1: 'Ponteiro na posição 1, fundo direito. Atua na recepção e defesa, podendo também preparar ataques de fundo pela entrada após a armação.',
        2: 'Ponteiro na posição 2, rede direita. Pode atuar como atacante de saída quando o levantador infiltra do fundo. Participa também do bloqueio lateral.',
        3: 'Ponteiro na posição 3, central na rede. Auxilia no bloqueio e pode ser opção de ataque em jogadas rápidas pelo meio, mas mantém foco na cobertura.',
        4: 'Ponteiro na posição 4, rede esquerda. Principal atacante de entrada, recebendo bolas abertas e diagonais. Atua também no bloqueio contra o oposto adversário.',
        5: 'Ponteiro na posição 5, fundo esquerdo. Forte participação na recepção e defesa, preparando-se para ataques de fundo pela entrada.',
        6: 'Ponteiro na posição 6, fundo central. Atua na defesa de diagonais longas e pode ser opção em contra-ataques de fundo, apoiando a armação'

      },
    },
  };


  void narrarTextoExplicativo() {
    final texto = explicacoesPorSistema[widget.sistema]?[jogadorSelecionado.toUpperCase()]?[rotacao] ?? '';
    if (texto.isNotEmpty) {
      flutterTts.speak(texto);
    }
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
                if (novoValor == null) return;

                setState(() {
                  jogadorSelecionado = novoValor;

                  // Fecha o vídeo atual se estiver visível
                  if (_isVideoVisible) {
                    _isVideoVisible = false;
                    _videoController.pause();
                    _videoController.dispose();
                    _currentVideoPath = null;
                  }
                });
              },




              items: (widget.sistema == '5x1'
                  ? jogadores5x1
                  : (widget.sistema == '4x2'
                  ? jogadores4x2
                  : (widget.sistema == '4x2 Invertido'
                  ? jogadores4x2I
                  : jogadores6x0)))


                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (widget.sistema != '5x1' && widget.sistema != '6x0' && widget.sistema != '4x2' && widget.sistema != '4x2 Invertido')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'O sistema "${widget.sistema}" ainda não está disponível.\nEm breve você poderá explorá-lo!',
                style: const TextStyle(fontSize: 18),
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
                    const Text(
                      'Referência da Posição na Quadra',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      imagemQuadraAtual,
                      height: 230,
                      fit: BoxFit.contain,
                    ),
                    if (_isVideoVisible && _videoController.value.isInitialized)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        ),
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
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Container(
                          key: ValueKey('$jogadorSelecionado-$rotacao'),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800, // Agora com melhor contraste
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),

                          child: Text(
                            explicacoesPorSistema[widget.sistema]?[jogadorSelecionado.toUpperCase()]?[rotacao] ?? '',
                            style: const TextStyle(fontSize: 14),
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
                            icon: const Icon(Icons.volume_up, color: Colors.white),
                            onPressed: narrarTextoExplicativo,
                            tooltip: 'Ouvir explicação',
                          ),
                          IconButton(
                              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                              onPressed: () async {
                                await _playVideo(); // 👈 Agora usamos o método que criamos para tocar o vídeo certo
                              },
                            ),

                          IconButton(
                            icon: const Icon(Icons.note, color: Colors.white),
                            onPressed: () {
                              // Em breve: abrir anotações
                            },
                            tooltip: 'Minhas anotações (em breve)',
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              // Em breve: compartilhar
                            },
                            tooltip: 'Compartilhar (em breve)',
                          ),
                          IconButton(
                            icon: const Icon(Icons.help_outline, color: Colors.white),
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
