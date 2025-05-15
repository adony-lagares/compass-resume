from calculadora import Calculadora
import pytest
import math

def test_soma():
    calc = Calculadora()
    assert calc.somar(2, 3) == 5

def test_subtracao():
    calc = Calculadora()
    assert calc.subtrair(5, 2) == 3

def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicar(3, 4) == 12

def test_divisao():
    calc = Calculadora()
    assert calc.dividir(10, 2) == 5

def test_divisao_por_zero():
    calc = Calculadora()
    with pytest.raises(ZeroDivisionError):
        calc.dividir(5, 0)

def test_potencia():
    calc = Calculadora()
    assert calc.potencia(2, 3) == 8

def test_raiz_quadrada():
    calc = Calculadora()
    assert calc.raiz(9) == 3

def test_raiz_quadrada_negativa():
    calc = Calculadora()
    with pytest.raises(ValueError):
        calc.raiz(-1)

def test_historico_de_operacoes():
    calc = Calculadora()
    calc.somar(2, 2)
    calc.subtrair(5, 1)
    assert calc.historico == [
        "Somou 2 + 2 = 4",
        "Subtraiu 5 - 1 = 4"
    ]

def test_operacoes_com_tipo_invalido():
    calc = Calculadora()
    with pytest.raises(TypeError):
        calc.somar("a", 1)
