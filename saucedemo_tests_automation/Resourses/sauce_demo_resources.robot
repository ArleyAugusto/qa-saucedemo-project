*** Settings ***
Library    SeleniumLibrary
Library    Screenshot
Library    String

*** Variables ***

${Pag_login}                 https://www.saucedemo.com
${campo_usuario}             user-name
${campo_senha}               password
${botao_login}               login-button
${Val_tela_catalogo}         //span[@class='title'][contains(.,'Products')]
${aviso_bloqueio}            //h3[@data-test='error'][contains(.,'Epic sadface: Sorry, this user has been locked out.')]
${imagem_bug}                //img[contains(@alt,'Sauce Labs Bike Light')]
${tempo_carregamento}        3    
${erro_usuario_vazio}        //h3[@data-test='error'][contains(.,'Epic sadface: Username is required')]  
${erro_senha_vazia}          //h3[@data-test='error'][contains(.,'Epic sadface: Password is required')]
${erro_user_senha_inv}       //h3[@data-test='error'][contains(.,'Epic sadface: Username and password do not match any user in this service')]
${campo_filtro}              //select[contains(@class,'product_sort_container')]
${campo_filtro_cresc}        //option[@value='lohi'][contains(.,'Price (low to high)')]
${campo_filtro_decres}       //option[@value='hilo'][contains(.,'Price (high to low)')]
${botao_add_to_cart}         //button[contains(@data-test,'add-to-cart-sauce-labs-onesie')]
${botao_carrinho_compras}    //a[@class='shopping_cart_link']



*** Keywords ***         

                                                # TELA DE LOGIN

Dado que estou na página de login do SauceDemo
    Open Browser    ${Pag_login}    gc
    Title Should Be    Swag Labs

Quando insiro o username "standard_user"
    Input Text    ${campo_usuario}    standard_user
    
E insiro a password "secret_sauce"
    Input Text    ${campo_senha}    secret_sauce
    
E clico no botão de login
    Click Button    ${botao_login}   
 
Então devo ser redirecionado para a página inicial do sistema
     Wait Until Element Is Visible    ${Val_tela_catalogo}
    

Quando insiro o username "locked_out_user" 
    Input Text    ${campo_usuario}    locked_out_user   

Então devo ver uma mensagem de usuário bloqueado
    Wait Until Element Is Visible    ${aviso_bloqueio}
       

Quando insiro o username "problem_user"
    Input Text    ${campo_usuario}    problem_user 

E as imagens dos produtos devem ser substituídas por fotos fora do contexto
    Element Should Be Visible    ${imagem_bug}    

Quando deixo o campo "username" vazio
    Clear Element Text    ${campo_usuario}

Então devo ver mensagem de erro de usuário
    Element Should Be Visible    ${erro_usuario_vazio}
    Close Browser

E deixo o campo "password" vazio
    Clear Element Text    ${campo_senha}

Então devo ver mensagem erro de senha
    Element Should Be Visible    ${erro_senha_vazia}
    Close Browser    

Quando insiro o username inválido
    Input Text    ${campo_usuario}    invalido 

E insiro a password inválido
    Input Text    ${campo_senha}    invalida

Então devo ver a mensagem erro usuario e senha invalidos
    Element Should Be Visible    ${erro_user_senha_inv}
    Close Browser
    

                                                # CATALOGO_PRODUTOS   

Dado que estou na página de listagem de produtos
    Open Browser    ${Pag_login}    gc
    Input Text    ${campo_usuario}    standard_user
    Input Text    ${campo_senha}    secret_sauce
    Click Button    ${botao_login}
    Wait Until Element Is Visible    ${Val_tela_catalogo} 

Quando eu seleciono o filtro de ordenação "Do maior para o menor"    
    Click Element    ${campo_filtro}
    Sleep    2s
    Click Element    ${campo_filtro_decres}

Então os produtos devem ser exibidos em ordem decrescente de preço
    Element Should Be Visible    ${campo_filtro_decres} 
    Sleep    2s
    Close Browser

Quando eu seleciono o filtro de ordenação "Do menor para o maior"
    Click Element    ${campo_filtro}
    Sleep    2s
    Click Element    ${campo_filtro_cresc}

Então os produtos devem ser exibidos em ordem crescente de preço
    Element Should Be Visible    ${campo_filtro_cresc} 
    Sleep    2s
    Close Browser

Quando eu clico no botão "Add to cart"
    Click Button    ${botao_add_to_cart}
    
Então o item deve ser adicionado ao meu carrinho    
    Element Should Be Visible    //span[@class='shopping_cart_badge'][contains(.,'1')]
    Sleep    2s
    Capture Page Screenshot
    Close Browser

Quando eu clico no botão "Add to cart" em dois produtos distintos  
    Click Button    ${botao_add_to_cart}
    Click Button    //button[contains(@data-test,'add-to-cart-sauce-labs-bike-light')]
     
    
Então os itens devem ser adicionados ao meu carrinho
    Element Should Be Visible    //span[@class='shopping_cart_badge'][contains(.,'2')]
    Sleep    2s
    Capture Page Screenshot
    Close Browser    

                                                # CARRINHO_COMPRAS

E que adiciono um item ao carrinho
    Click Button    ${botao_add_to_cart}
     

Quando acesso a página do carrinho
    Click Element    ${botao_carrinho_compras}
    Element Should Be Visible    //span[@class='title'][contains(.,'Your Cart')]     

Então devo ver o item adicionado exibido corretamente
    Element Should Be Visible    //div[contains(@class,'cart_list')]

E item deve mostrar a quantidade e valor correto
    ${quantidade}            Get Text         //div[@class='cart_quantity']
    Should Be Equal As Numbers        ${quantidade}    1
    ${valor_item}            Get Text         //div[@class='inventory_item_price']
    Should Be Equal As Strings        ${valor_item}    $7.99
            
Dado que estou na página do carrinho com itens adicionados
    Open Browser    ${Pag_login}    gc
    Input Text    ${campo_usuario}    standard_user
    Input Text    ${campo_senha}    secret_sauce
    Click Button    ${botao_login}
    Wait Until Element Is Visible    ${Val_tela_catalogo}
    Click Button    ${botao_add_to_cart}
    Click Element    ${botao_carrinho_compras}
    Element Should Be Visible    //span[@class='title'][contains(.,'Your Cart')]  

Quando removo um item do carrinho
    Click Element    //button[@class='btn btn_secondary btn_small cart_button'][contains(.,'Remove')]

Então o item removido não deve mais ser exibido na lista de produtos do carrinho
    Element Should Not Be Visible    //div[@class='cart_quantity']

Dado que estou na página do carrinho
    Open Browser    ${Pag_login}    gc
    Input Text    ${campo_usuario}    standard_user
    Input Text    ${campo_senha}    secret_sauce
    Click Button    ${botao_login}
    Wait Until Element Is Visible    ${Val_tela_catalogo}
    Click Element    ${botao_carrinho_compras}
    Element Should Be Visible    //span[@class='title'][contains(.,'Your Cart')]
       
Quando eu clico no botão "Continue Shopping"
    Click Button    continue-shopping

Então eu devo ser redirecionado de volta a página de listagem de produtos
    Wait Until Element Is Visible    ${Val_tela_catalogo}

Quando eu clico no botão "Checkout"
    Click Button    checkout
    
Então eu devo ser redirecionado para a página de checkout
    Wait Until Element Is Visible    //span[@class='title'][contains(.,'Checkout: Your Information')]   