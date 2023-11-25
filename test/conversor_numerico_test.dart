import 'package:conversor_romano_arabico/conversor_exception.dart';
import 'package:test/test.dart';
import 'package:conversor_romano_arabico/conversor_numerico.dart';

void main() {
  group('Testes de conversão de arábico para romano', () {
    test('Deve converter o valor de arábico para romano', () {
      expect(ConversorNumerico.arabicoParaRomano(numeroArabico: 999), 'CMXCIX');
    });

    test('Deve lançar uma exceção de valor inválido', () {
      expect(
        () => ConversorNumerico.arabicoParaRomano(numeroArabico: 0),
        throwsA(isA<ConversorException>()),
      );
      expect(
        () => ConversorNumerico.arabicoParaRomano(numeroArabico: 4000),
        throwsA(isA<ConversorException>()),
      );
    });
  });

  group('Testes de conversão de romano para arábico', () {
    test('Deve converter o valor de romano para arábico', () {
      expect(ConversorNumerico.romanoParaArabico(numeroRomano: 'CMXCIX'), 999);
    });

    test('Deve lançar uma exceção de valor inválido', () {
      expect(
        () => ConversorNumerico.romanoParaArabico(numeroRomano: 'ABCD'),
        throwsA(isA<ConversorException>()),
      );
    });

    test('Deve lançar uma exceção de valor vazio', () {
      expect(
        () => ConversorNumerico.romanoParaArabico(numeroRomano: ''),
        throwsA(isA<ConversorException>()),
      );
    });
  });
}
