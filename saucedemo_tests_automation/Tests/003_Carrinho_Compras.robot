*** Settings ***
Library          SeleniumLibrary
Resource         ../Resourses/sauce_demo_resources.robot
Test Setup       
Test Teardown    

*** Test Cases ***

CT003-001: Validar a exibição dos itens adicionados no carrinho
    Dado que estou na página de listagem de produtos
    E que adiciono um item ao carrinho
    Quando acesso a página do carrinho
    Então devo ver o item adicionado exibido corretamente
    E item deve mostrar a quantidade e valor correto

CT003-002: Remover um item do carrinho
    Dado que estou na página do carrinho com itens adicionados
    Quando removo um item do carrinho
    Então o item removido não deve mais ser exibido na lista de produtos do carrinho

CT003-003: Continuar comprando e voltar ao catálogo
    Dado que estou na página do carrinho
    Quando eu clico no botão "Continue Shopping"
    Então eu devo ser redirecionado de volta a página de listagem de produtos

CT003-004: Navegar para a próxima etapa (Checkout)
    Dado que estou na página do carrinho com itens adicionados
    Quando eu clico no botão "Checkout"
    Então eu devo ser redirecionado para a página de checkout