INSERT INTO locais (nome_espaco, cep, logradouro, numero, complemento, bairro, cidade, uf, capacidade_maxima) VALUES
('Arena Anhembi', '02012021', 'Avenida Olavo Fontoura', '1209', 'Portão 1', 'Santana', 'São Paulo', 'SP', 30000),
('Espaço Unimed', '01156000', 'Rua Tagipuru', '795', NULL, 'Barra Funda', 'São Paulo', 'SP', 8000),
('Allianz Parque', '05001100', 'Avenida Francisco Matarazzo', '1705', 'Caixa Belas Artes', 'Água Branca', 'São Paulo', 'SP', 45000),
('Audio Club', '01156001', 'Avenida Francisco Matarazzo', '694', NULL, 'Água Branca', 'São Paulo', 'SP', 3000),
('Vivo Rio', '20021010', 'Avenida Infante Dom Henrique', '85', NULL, 'Aterro do Flamengo', 'Rio de Janeiro', 'RJ', 4000);

INSERT INTO eventos (nome_evento, data_evento, faixa_etaria, status, id_local) VALUES
('Festival RockFest 2026', '2026-11-15 18:00:00', '16 anos', 'Agendado', 1),
('Noite do MPB Live', '2026-12-05 20:30:00', 'Livre', 'Agendado', 2),
('Samba & Pagode In Rio', '2026-11-20 16:00:00', '18 anos', 'Agendado', 5),
('Pop Star World Tour', '2026-12-10 21:00:00', '14 anos', 'Agendado', 3),
('Indie Summer Night', '2026-11-28 22:00:00', '18 anos', 'Agendado', 4);

INSERT INTO categorias_ingressos (nome_categoria, preco, quantidade_disponivel, id_evento) VALUES
('Pista Comum', 150.00, 5000, 1),
('Pista VIP', 350.00, 1000, 1),
('Cadeira Premium', 200.00, 1500, 2),
('Pista Premium', 500.00, 2000, 4),
('Pista Única', 120.00, 800, 5);

INSERT INTO clientes (nome, cpf, email, telefone) VALUES
('Carlos Eduardo Silva', '12345678901', 'carlos.silva@email.com', '11987654321'),
('Mariana Oliveira Santos', '98765432100', 'mariana.santos@email.com', '11976543210'),
('Lucas Ferreira Lima', '45678912304', 'lucas.lima@email.com', '21965432109'),
('Beatriz Souza Alves', '32165498705', 'beatriz.alves@email.com', '11954321098'),
('Fernando Rossi Castro', '65498732106', 'fernando.castro@email.com', '21943210987');

INSERT INTO compras (data_compra, valor_total, forma_pagamento, status_pagamento, id_cliente) VALUES
('2026-10-20 14:30:00', 500.00, 'PIX', 'Aprovado', 1),
('2026-10-21 09:15:00', 200.00, 'Cartao credito', 'Aprovado', 2),
('2026-10-22 18:45:00', 150.00, 'Boleto', 'Pendente', 3),
('2026-10-23 11:20:00', 500.00, 'PIX', 'Aprovado', 4),
('2026-10-24 16:10:00', 120.00, 'Cartao credito', 'Cancelado', 5);

INSERT INTO ingressos_emitidos (codigo_qr, status_utilizacao, id_compra, id_categoria) VALUES
('QR-ROCK-2026-0001', 'Valido', 1, 1),
('QR-ROCK-2026-0002', 'Valido', 1, 2),
('QR-MPB-2026-0001', 'Utilizado', 2, 3),
('QR-POP-2026-0001', 'Valido', 4, 4),
('QR-IND-2026-0001', 'Cancelado', 5, 5);

