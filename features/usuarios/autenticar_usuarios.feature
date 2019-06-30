# language: pt
# encoding: utf-8

Funcionalidade: Autenticação de usuários no sistema
  Como usuário cadastrado, mas deslogado
  Eu quero me autenticar no sistema
  Para que eu possa acessar o conteudo da plataforma de controle de estoque

  Cenário: Um usuário faz autenticação no sistema com sucesso
    Dado que eu esteja na página principal e já seja um usuário cadastrado
    Quando eu preencher o formulário com:
      | user_email | a@a.com |
      | user_password | password123 |
    E clicar em "Log in"
    Então devo estar na tela de usuarios autenticados na rota "/backoffice/admin"
