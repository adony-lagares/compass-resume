*** Settings ***
Resource        ../keywords/booking_keywords.robot
Suite Setup     Criar Sessao
Suite Teardown  Teardown Condicional

*** Test Cases ***
Cenário: GET Todos os Bookings 200
    [Tags]    GET    Public
    Criar Sessao
    GET Todos os Bookings
    Validar Status Code "200"

Cenário: Autenticação e Token 200
    [Tags]    AUTH    Token
    Criar Sessao
    Autenticar

Cenário: POST Criar Nova Reserva 200
    [Tags]    POST    CRUD
    Criar Sessao
    Criar Datas da Reserva
    POST Nova Reserva
    Validar Status Code "200"

Cenário: GET Reserva por ID 200
    [Tags]    GET    CRUD
    Criar Sessao
    Criar Datas da Reserva
    POST Nova Reserva
    GET Reserva Por ID
    Validar Status Code "200"

Cenário: PUT Atualizar Reserva 200
    [Tags]    PUT    CRUD
    Criar Sessao
    Criar Datas da Reserva
    Autenticar
    POST Nova Reserva
    Atualizar Reserva Por ID
    Validar Status Code "200"

Cenário: DELETE Excluir Reserva 201
    [Tags]    DELETE    CRUD
    Criar Sessao
    Criar Datas da Reserva
    Autenticar
    POST Nova Reserva
    Deletar Reserva Por ID
    Should Be Equal As Strings    ${DELETE_RESPONSE.status_code}    201
