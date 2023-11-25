import 'conversor_exception.dart';

class ConversorNumerico {
  static int romanoParaArabico({required String numeroRomano}) {
    int i, numeroArabico = 0;
    Map<String, int> algarismosRomanos = {'M': 1000, 'D': 500, 'C': 100, 'L': 50, 'X': 10, 'V': 5, 'I': 1};

    if (numeroRomano.isEmpty) {
      throw ConversorException('Número romano não pode ser vazio.');
    }
    if (numeroRomano.contains(RegExp(r'[^MDCLXVI]'))) {
      throw ConversorException('Número romano inválido.');
    }

    for (i = 0; i < numeroRomano.length; i++) {
      // Percorre os elementos da String que forma o número romano

      if (i + 1 < numeroRomano.length) {
        // Verica se o algarismo analisado atualmente é menor que o último

        if (numeroRomano.length > 1 && i + 1 < numeroRomano.length) {
          // Verifica se o algarismo D não é repetido
          if ((numeroRomano[i] == 'D') && (numeroRomano[i + 1] == 'D')) {
            throw ConversorException('O algarismo D não pode ser repetido.');
          }
        }

        if (numeroRomano.length > 3 && i + 3 < numeroRomano.length) {
          // Verifica se o algarismo não é repetido mais de 3 vezes seguidas
          if ((numeroRomano[i] == numeroRomano[i + 1]) &&
              (numeroRomano[i + 1] == numeroRomano[i + 2]) &&
              (numeroRomano[i + 2] == numeroRomano[i + 3])) {
            throw ConversorException('O algarismo ${numeroRomano[i]} não pode ser repetido mais de 3 vezes seguidas.');
          }
        }

        if (algarismosRomanos[numeroRomano[i]]! >= algarismosRomanos[numeroRomano[i + 1]]!) {
          // Quando o algarismo romano é maior ou igual ao próximo, soma-se o valor do algarismo atual ao número arábico
          numeroArabico += algarismosRomanos[numeroRomano[i]]!;
        } else {
          if ((numeroRomano[i] == 'I') && (numeroRomano[i + 1] != 'V') && (numeroRomano[i + 1] != 'X')) {
            // Verifica se o algarismo I é antecessor de valores diferentes de V ou X
            throw ConversorException('O algarismo I só pode ser antecessor de V e X.');
          }

          if ((numeroRomano[i] == 'X') && (numeroRomano[i + 1] != 'L') && (numeroRomano[i + 1] != 'C')) {
            // Verifica se o algarismo X é antecessor de valores diferentes de L ou C
            throw ConversorException('O algarismo X só pode ser antecessor de L e C.');
          }

          if ((numeroRomano[i] == 'C') && (numeroRomano[i + 1] != 'D') && (numeroRomano[i + 1] != 'M')) {
            // Verifica se o algarismo C é antecessor de valores diferentes de D ou M
            throw ConversorException('O algarismo C só pode ser antecessor de D e M.');
          }

          // Quando o algarismo romano é menor que o próximo, subtrai-se o valor do próximo pelo atual e soma-se o resultado ao número arábico
          numeroArabico += algarismosRomanos[numeroRomano[i + 1]]! - algarismosRomanos[numeroRomano[i]]!;

          i++;
        }
      } else {
        // Caso seja o último elemento, soma-se o valor do algarismo atual ao número arábico
        numeroArabico += algarismosRomanos[numeroRomano[i]]!;
      }
    }

    return numeroArabico;
  }

  static String arabicoParaRomano({required int numeroArabico}) {
    String numeroRomano = '';

    if (numeroArabico < 1 || numeroArabico > 3999) {
      /* 
        Como não se pode repetir um algarismo romano mais de 3 vezes seguidas, 
        o número arábico não pode ser maior que 3999
       */
      throw ConversorException('Não é possível converter números menores que 1 ou maiores que 3999.');
    }

    while (numeroArabico > 0) {
      /*
        Enquanto o número arábico for maior que 0, 
        o algoritmo irá verificar, em ordem decrescente, se ele é maior ou igual 
        aos possíveis valores de algarismo romano e suas combinações.
        Caso seja, o algarismo romano ou combinação correspondente será concatenado à String que armazena o número romano.
        Em seguida, o valor do algarismo em questão será subtraído do número arábico
      */
      if (numeroArabico >= 1000) {
        numeroRomano += 'M';
        numeroArabico -= 1000;
      } else if (numeroArabico >= 900) {
        numeroRomano += 'CM';
        numeroArabico -= 900;
      } else if (numeroArabico >= 500) {
        numeroRomano += 'D';
        numeroArabico -= 500;
      } else if (numeroArabico >= 400) {
        numeroRomano += 'CD';
        numeroArabico -= 400;
      } else if (numeroArabico >= 100) {
        numeroRomano += 'C';
        numeroArabico -= 100;
      } else if (numeroArabico >= 90) {
        numeroRomano += 'XC';
        numeroArabico -= 90;
      } else if (numeroArabico >= 50) {
        numeroRomano += 'L';
        numeroArabico -= 50;
      } else if (numeroArabico >= 40) {
        numeroRomano += 'XL';
        numeroArabico -= 40;
      } else if (numeroArabico >= 10) {
        numeroRomano += 'X';
        numeroArabico -= 10;
      } else if (numeroArabico >= 9) {
        numeroRomano += 'IX';
        numeroArabico -= 9;
      } else if (numeroArabico >= 5) {
        numeroRomano += 'V';
        numeroArabico -= 5;
      } else if (numeroArabico >= 4) {
        numeroRomano += 'IV';
        numeroArabico -= 4;
      } else if (numeroArabico >= 1) {
        numeroRomano += 'I';
        numeroArabico -= 1;
      }
    }

    return numeroRomano;
  }
}
