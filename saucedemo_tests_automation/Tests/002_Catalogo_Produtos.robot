*** Settings ***
Library          SeleniumLibrary
Resource         ../Resourses/sauce_demo_resources.robot
Test Setup       
Test Teardown    

*** Test Cases ***

CT002-001: Validar filtro de ordenação dos produtos (high to low)
    Dado que estou na página de listagem de produtos
    Quando eu seleciono o filtro de ordenação "Do maior para o menor"
    Então os produtos devem ser exibidos em ordem decrescente de preço

CT002-002: Validar filtro de ordenação dos produtos (low to high)
    Dado que estou na página de listagem de produtos
    Quando eu seleciono o filtro de ordenação "Do menor para o maior"
    Então os produtos devem ser exibidos em ordem crescente de preço

CT002-003: Adicionar um item ao carrinho
    Dado que estou na página de listagem de produtos
    Quando eu clico no botão "Add to cart"
    Então o item deve ser adicionado ao meu carrinho

CT002-004: Adicionar vários itens ao carrinho
    Dado que estou na página de listagem de produtos
    Quando eu clico no botão "Add to cart" em dois produtos distintos
    Então os itens devem ser adicionados ao meu carrinho