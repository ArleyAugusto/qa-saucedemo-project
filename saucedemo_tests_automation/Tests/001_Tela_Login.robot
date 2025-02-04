*** Settings ***
Library          SeleniumLibrary
Resource         ../Resourses/sauce_demo_resources.robot
Test Setup       
Test Teardown    

*** Test Cases ***

CT001-001-Login com standard_user
    Dado que estou na página de login do SauceDemo
    Quando insiro o username "standard_user"
    E insiro a password "secret_sauce"
    E clico no botão de login
    Então devo ser redirecionado para a página inicial do sistema

CT001-002-Login com locked_out_user
    Dado que estou na página de login do SauceDemo
    Quando insiro o username "locked_out_user"
    E insiro a password "secret_sauce"
    E clico no botão de login
    Então devo ver uma mensagem de usuário bloqueado

CT001-003-Login com problem_user
    Dado que estou na página de login do SauceDemo
    Quando insiro o username "problem_user"
    E insiro a password "secret_sauce"
    E clico no botão de login
    Então devo ser redirecionado para a página inicial do sistema
    E as imagens dos produtos devem ser substituídas por fotos fora do contexto
    

CT001-004-Login com campo "username" vazio
    Dado que estou na página de login do SauceDemo
    Quando deixo o campo "username" vazio
    E insiro a password "secret_sauce"
    E clico no botão de login
    Então devo ver mensagem de erro de usuário

CT001-005-Login com campo "password" vazio
    Dado que estou na página de login do SauceDemo
    Quando insiro o username "standard_user"
    E deixo o campo "password" vazio
    E clico no botão de login
    Então devo ver mensagem erro de senha

CT001-006-Login com credenciais inválidas
    Dado que estou na página de login do SauceDemo
    Quando insiro o username inválido
    E insiro a password inválido
    E clico no botão de login
    Então devo ver a mensagem erro usuario e senha invalidos

