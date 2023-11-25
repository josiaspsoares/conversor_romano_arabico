import 'package:conversor_romano_arabico/conversor_numerico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _romanoController = TextEditingController();
  final TextEditingController _arabicoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversor Romano-Arábico'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _arabicoController,
                decoration: const InputDecoration(
                  labelText: 'Número Arábico',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número';
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.disabled,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 4,
                onChanged: (_) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  setState(() {
                    try {
                      final int numeroArabico = int.tryParse(_arabicoController.text) ?? 0;

                      _romanoController.text = ConversorNumerico.arabicoParaRomano(numeroArabico: numeroArabico);
                    } on Exception catch (e) {
                      _romanoController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  });
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _romanoController,
                decoration: const InputDecoration(
                  labelText: 'Número Romano',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número';
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.disabled,
                maxLength: 9,
                onChanged: (_) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  setState(() {
                    try {
                      final String numeroRomano = _romanoController.text.toUpperCase();

                      _arabicoController.text = ConversorNumerico.romanoParaArabico(numeroRomano: numeroRomano).toString();
                    } on Exception catch (e) {
                      _arabicoController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
