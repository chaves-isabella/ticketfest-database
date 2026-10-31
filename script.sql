CREATE DATABASE IF NOT EXISTS db_ticketfest;
USE db_ticketfest;

CREATE TABLE IF NOT EXISTS locais (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    nome_espaco VARCHAR(150) NOT NULL,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50) NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    capacidade_maxima INT NOT NULL CHECK (capacidade_maxima > 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome_evento VARCHAR(200) NOT NULL,
    data_evento DATETIME NOT NULL,
    faixa_etaria VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Agendado', 'Em andamento', 'Concluido', 'Cancelado')),
    id_local INT NOT NULL,
    CONSTRAINT fk_evento_local FOREIGN KEY (id_local) REFERENCES locais(id_local) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categorias_ingressos (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    quantidade_disponivel INT NOT NULL CHECK (quantidade_disponivel >= 0),
    id_evento INT NOT NULL,
    CONSTRAINT fk_categoria_evento FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(15) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS compras (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    data_compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    forma_pagamento VARCHAR(30) NOT NULL CHECK (forma_pagamento IN ('PIX', 'Cartao credito', 'Boleto')),
    status_pagamento VARCHAR(20) NOT NULL CHECK (status_pagamento IN ('Aprovado', 'Pendente', 'Cancelado')),
    id_cliente INT NOT NULL,
    CONSTRAINT fk_compra_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ingressos_emitidos (
    id_ingresso INT AUTO_INCREMENT PRIMARY KEY,
    codigo_qr VARCHAR(100) UNIQUE NOT NULL,
    status_utilizacao VARCHAR(20) NOT NULL DEFAULT 'Valido' CHECK (status_utilizacao IN ('Valido', 'Utilizado', 'Cancelado')),
    id_compra INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_ingresso_compra FOREIGN KEY (id_compra) REFERENCES compras(id_compra) ON DELETE CASCADE,
    CONSTRAINT fk_ingresso_categoria FOREIGN KEY (id_categoria) REFERENCES categorias_ingressos(id_categoria)
) ENGINE=InnoDB;