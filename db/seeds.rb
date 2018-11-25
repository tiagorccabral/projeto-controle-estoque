User.delete_all
User.create(email: 'admin@admin.com', password: 'admin123', name: 'Administrador Central')

Item.create(name: 'Caneta Bic', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'Faber Castel', receiver: 'Vanessa', created_at: '2018-05-12 17:48:10.664498')

Item.create(name: 'Lapiseira Pentel', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'Pentel', receiver: 'Vanessa', created_at: '2018-05-12 17:48:10.664498')

Item.create(name: 'Borracha Faber Caster', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'Faber Castel', receiver: 'Vanessa', created_at: '2018-05-12 17:48:10.664498')

Item.create(name: 'Televisão 40 polegadas', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'UnB', receiver: 'Vanessa', created_at: '2018-11-10 12:00:10.664498')

Item.create(name: 'Livro História', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'UnB', receiver: 'Luis Carlos', created_at: '2018-11-10 12:05:10.664498')

Item.create(name: 'Livro Matemática Cáculo 1', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'UnB', receiver: 'Luis Carlos', created_at: '2018-11-10 12:10:10.664498')

Item.create(name: 'Macarrão Espaguetti', amount: rand(1..20).to_i, value: rand(3..50),
            donor: 'Instituto Dona Maria', receiver: 'Rubens', created_at: '2018-06-08 17:48:10.664498')

Item.create(name: 'Ar condicionado', amount: rand(1..5).to_i, value: rand(500..2000),
            donor: 'Brastemp', receiver: 'Vanessa', created_at: '2018-09-06 17:48:10.664498')

Item.create(name: 'Geladeira 110L', amount: rand(1..5).to_i, value: rand(1000..2000),
            donor: 'Brastemp', receiver: 'Vanessa', created_at: '2018-09-06 17:53:10.664498')

Item.create(name: 'iPhone 5c', amount: rand(1..5).to_i, value: rand(1000..2500),
            donor: 'Ponto Frio', receiver: 'Amaral', created_at: '2018-10-05 17:53:10.664498')

Item.create(name: 'iPhone 6s', amount: rand(1..5).to_i, value: rand(1000..2500),
            donor: 'Ponto Frio', receiver: 'Amaral', created_at: '2018-09-06 17:59:10.664498')
