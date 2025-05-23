import pytest
from calculadora import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

@pytest.mark.parametrize("a, b, esperado", [
    (2, 3, 5),
    (-1, 1, 0),
    (0, 0, 0),
])
def test_soma(calc, a, b, esperado):
    assert calc.somar(a, b) == esperado

@pytest.mark.parametrize("a, b, esperado", [
    (5, 2, 3),
    (10, 10, 0),
    (-5, -5, 0),
])
def test_subtracao(calc, a, b, esperado):
    assert calc.subtrair(a, b) == esperado

@pytest.mark.parametrize("a, b, esperado", [
    (3, 4, 12),
    (0, 5, 0),
    (-2, 3, -6),
])
def test_multiplicacao(calc, a, b, esperado):
    assert calc.multiplicar(a, b) == esperado

@pytest.mark.parametrize("a, b, esperado", [
    (10, 2, 5),
    (9, 3, 3),
    (7.5, 2.5, 3),
])
def test_divisao(calc, a, b, esperado):
    assert calc.dividir(a, b) == esperado

def test_divisao_por_zero(calc):
    with pytest.raises(ZeroDivisionError):
        calc.dividir(5, 0)

@pytest.mark.parametrize("base, expoente, esperado", [
    (2, 3, 8),
    (5, 0, 1),
    (9, 0.5, 3),
])
def test_potencia(calc, base, expoente, esperado):
    assert calc.potencia(base, expoente) == esperado

@pytest.mark.parametrize("numero, esperado", [
    (9, 3),
    (0, 0),
    (16, 4),
])
def test_raiz_quadrada(calc, numero, esperado):
    assert calc.raiz(numero) == esperado

def test_raiz_quadrada_negativa(calc):
    with pytest.raises(ValueError):
        calc.raiz(-1)

def test_historico_de_operacoes(calc):
    calc.somar(2, 2)
    calc.subtrair(5, 1)
    assert calc.historico == [
        "Somou 2 + 2 = 4",
        "Subtraiu 5 - 1 = 4"
    ]

@pytest.mark.parametrize("a, b", [
    ("a", 1),
    (None, 3),
    ([1], 2),
])
def test_operacoes_com_tipo_invalido(calc, a, b):
    with pytest.raises(TypeError):
        calc.somar(a, b)
