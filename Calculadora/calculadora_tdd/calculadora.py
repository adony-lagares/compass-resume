import math

class Calculadora:
    def __init__(self):
        self.historico = []

    def _validar_numeros(self, *args):
        for arg in args:
            if not isinstance(arg, (int, float)):
                raise TypeError("Apenas números são permitidos.")

    def somar(self, a, b):
        self._validar_numeros(a, b)
        resultado = a + b
        self.historico.append(f"Somou {a} + {b} = {resultado}")
        return resultado

    def subtrair(self, a, b):
        self._validar_numeros(a, b)
        resultado = a - b
        self.historico.append(f"Subtraiu {a} - {b} = {resultado}")
        return resultado

    def multiplicar(self, a, b):
        self._validar_numeros(a, b)
        resultado = a * b
        self.historico.append(f"Multiplicou {a} * {b} = {resultado}")
        return resultado

    def dividir(self, a, b):
        self._validar_numeros(a, b)
        if b == 0:
            raise ZeroDivisionError("Não é possível dividir por zero.")
        resultado = a / b
        self.historico.append(f"Dividiu {a} / {b} = {resultado}")
        return resultado

    def potencia(self, base, expoente):
        self._validar_numeros(base, expoente)
        resultado = base ** expoente
        self.historico.append(f"Potência {base} ** {expoente} = {resultado}")
        return resultado

    def raiz(self, numero):
        self._validar_numeros(numero)
        if numero < 0:
            raise ValueError("Não é possível calcular a raiz de número negativo.")
        resultado = math.sqrt(numero)
        self.historico.append(f"Raiz de {numero} = {resultado}")
        return resultado
