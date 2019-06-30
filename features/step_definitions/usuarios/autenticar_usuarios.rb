Dado("que eu esteja na página principal e já seja um usuário cadastrado") do
  User.create(password: "password123", email: "a@a.com", name: "User Admin")
  visit("/")
end

Quando("eu clicar em {string}") do |string|
  click_button("#{string}")
end

E("eu esteja agora em uma página com o título {string}") do |string|
  page.has_content?("#{string}")
end

Quando("eu preencher o formulário com:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.rows_hash.each do |field, value|
    fill_in field, :with => value
  end
end

E("clicar em {string}") do |string|
  click_button(string)
end

Então("eu devo estar em uma página com o título {string}") do |string|
  expect(page).to have_content(string)
end

E("deve haver um botão na tela com a opção de {string} pois eu já estarei logado no sistema") do |string|
  expect(page).to have_content(string)
end

Então("devo estar na tela de usuarios autenticados na rota {string}") do |string|
  expect(page).to have_current_path(string)
end