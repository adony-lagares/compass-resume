*** Settings ***
Library    RequestsLibrary
Resource   ../resources/variables.robot

*** Keywords ***
Criar Sessao
    Create Session    restful    ${BASE_URL}

Autenticar
    ${body}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=    POST On Session    restful    /auth    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['token']}
    Set Global Variable    ${TOKEN}    ${token}

GET Todos os Bookings
    ${response}=    GET On Session    restful    /booking
    Set Global Variable    ${RESPONSE}    ${response}

Validar Status Code "${code}"
    Should Be Equal As Strings    ${RESPONSE.status_code}    ${code}

POST Nova Reserva
    ${bookingdates}=    Create Dictionary    checkin=2024-05-01    checkout=2024-05-10
    &{payload}=    Create Dictionary
    ...    firstname=Batman
    ...    lastname=Wayne
    ...    totalprice=999
    ...    depositpaid=True
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Batmobile

    ${response}=    POST On Session    restful    /booking    json=${payload}
    Set Global Variable    ${RESPONSE}    ${response}
    Log To Console    Reserva criada: ${response.json()}

GET Reserva Por ID
    ${body}=    Set Variable    ${RESPONSE.json()}
    ${id}=      Set Variable    ${body['bookingid']}
    ${get_response}=    GET On Session    restful    /booking/${id}
    Log To Console    >>> Detalhes da Reserva com ID ${id}: ${get_response.json()}
    Set Global Variable    ${GET_RESPONSE}    ${get_response}

Atualizar Reserva Por ID
    ${body}=    Set Variable    ${RESPONSE.json()}
    ${id}=      Set Variable    ${body['bookingid']}

    &{update_payload}=    Create Dictionary
    ...    firstname=Bruce
    ...    lastname=Wayne
    ...    totalprice=555
    ...    depositpaid=False
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Cave

    ${headers}=    Create Dictionary    Cookie=token=${TOKEN}
    ${put_response}=    PUT On Session    restful    /booking/${id}    headers=${headers}    json=${update_payload}
    Set Global Variable    ${PUT_RESPONSE}    ${put_response}
    Log To Console    >>> Reserva atualizada: ${put_response.json()}

Criar Datas da Reserva
    ${bookingdates}=    Create Dictionary    checkin=2024-05-01    checkout=2024-05-10
    Set Suite Variable    ${bookingdates}    ${bookingdates}

Deletar Reserva Por ID
    ${body}=    Set Variable    ${RESPONSE.json()}
    ${id}=      Set Variable    ${body['bookingid']}
    ${headers}=    Create Dictionary    Cookie=token=${TOKEN}
    ${delete_response}=    DELETE On Session    restful    /booking/${id}    headers=${headers}
    Set Global Variable    ${DELETE_RESPONSE}    ${delete_response}
    Log To Console    >>> Reserva ID ${id} excluída com status: ${delete_response.status_code}

Teardown Condicional
    Run Keyword If    '${RESPONSE}' != 'None'    Verificar E Deletar Reserva Criada
    Limpar Variáveis
    Encerrar Sessao
    Log To Console    *** Teardown completo executado ***

Verificar E Deletar Reserva Criada
    ${json}=    Evaluate    json.loads("""${RESPONSE.text}""")    modules=json
    Run Keyword If    'bookingid' in ${json}
    ...    Deletar Reserva No Teardown    ${json['bookingid']}

Deletar Reserva No Teardown
    [Arguments]    ${id}
    ${headers}=    Create Dictionary    Cookie=token=${TOKEN}
    ${result}=    Run Keyword And Ignore Error    DELETE On Session    restful    /booking/${id}    headers=${headers}
    ${status}=    Set Variable If    '${result[0]}' == 'PASS'    ${result[1].status_code}    N/A
    Log To Console    >>> Teardown: Exclusão de ID ${id} retornou status ${status}

Limpar Variáveis
    Set Global Variable    ${TOKEN}             None
    Set Global Variable    ${RESPONSE}          None
    Set Global Variable    ${GET_RESPONSE}      None
    Set Global Variable    ${PUT_RESPONSE}      None
    Set Global Variable    ${DELETE_RESPONSE}   None

Encerrar Sessao
    Delete All Sessions