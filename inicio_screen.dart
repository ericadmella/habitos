import 'package:flutter/material.dart';

import 'ficha_principal_screen.dart';

/// Pantalla de bienvenida (Diseño de Interfaces).
/// Pide nombre y objetivo diario y los pasa al constructor de la principal.
class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  // Un TextEditingController por campo, creados FUERA de build.
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _objetivoCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    // Liberamos los controladores.
    _nombreCtrl.dispose();
    _objetivoCtrl.dispose();
    super.dispose();
  }

  void _comenzar() {
    final nombre = _nombreCtrl.text.trim();
    final objetivo = int.tryParse(_objetivoCtrl.text.trim());
    if (nombre.isEmpty || objetivo == null || objetivo < 1) {
      setState(() => _error = 'Escribe tu nombre y un objetivo mayor que 0');
      return;
    }
    setState(() => _error = null);
    // Navegación: push + MaterialPageRoute pasando los datos al constructor.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FichaPrincipalScreen(nombre: nombre, objetivo: objetivo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenida')),
      // SingleChildScrollView: evita que el contenido quede cortado con el teclado.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Icon(Icons.eco_rounded, size: 72, color: tema.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'HabitosApp',
              textAlign: TextAlign.center,
              style: tema.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nombreCtrl,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nombre del usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _objetivoCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Objetivo diario de hábitos',
                border: OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: tema.colorScheme.error)),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _comenzar,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              child: const Text('Comenzar'),
            ),
          ],
        ),
      ),
    );
  }
}
