import 'package:flutter/material.dart';
import 'sistema_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String sistemaSelecionado = '5x1';

  final List<String> sistemasDisponiveis = [
    '5x1',
    '6x0',
    '4x2',
    '4x2 Invertido',
  ];

  double _logoOpacity = 0.0; // 👈 começa invisível

  @override
  void initState() {
    super.initState();
    // 👇 Aciona animação após pequeno delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _logoOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Volleyball System'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const SizedBox(height: 0),

                // 🔽 Animação suave do logo
                AnimatedOpacity(
                  opacity: _logoOpacity,
                  duration: const Duration(milliseconds: 4000),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0), // 👈 ajusta distância do topo
                    child: Image.asset(
                      'assets/geral/Logo_Redondo_Sem_Misto.png',
                      height: 300,
                    ),
                  ),
                ),

                const SizedBox(height: 40), // 🔼 Distância entre imagem e texto

                // Frase de orientação
                const Text(
                  'Escolha o Sistema de Jogo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // Dropdown de sistemas
                DropdownButtonFormField<String>(
                  initialValue: sistemaSelecionado,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                  ),
                  items: sistemasDisponiveis.map((sistema) {
                    return DropdownMenuItem<String>(
                      value: sistema,
                      child: Text(sistema),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      sistemaSelecionado = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Botão "Começar Estudo"
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SistemaScreen(sistema: sistemaSelecionado),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('COMEÇAR ESTUDO'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
