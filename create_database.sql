CREATE TABLE colecionador (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(255),
    email VARCHAR(100),
    senha VARCHAR(255)
);

CREATE TABLE estado (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(75),
  uf VARCHAR(2)
);

CREATE TABLE cidade (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60),
    id_estado INT,
    CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado (id)
);

CREATE TABLE endereco (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(150),
    numero VARCHAR(20),
    bairro VARCHAR(50),
    cep VARCHAR(10),
    id_cidade INT,
    id_colecionador INT,
    CONSTRAINT fk_endereco_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id),
    CONSTRAINT fk_endereco_colecionador FOREIGN KEY (id_colecionador) REFERENCES colecionador (id)
);

CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255)
);

CREATE TABLE colecao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao TEXT,
    data_inicio DATE,
    completa TINYINT,
    id_colecionador INT,
    id_categoria INT,
    CONSTRAINT fk_colecao_colecianador FOREIGN KEY (id_colecionador) REFERENCES colecionador (id),
    CONSTRAINT fk_colecao_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id)
);

CREATE TABLE itens_colecao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao TEXT,
    imagem TEXT,
    id_colecao INT,
    CONSTRAINT fk_item_colecao_colecao FOREIGN KEY (id_colecao) REFERENCES colecao (id)
);


/*Procedure caso a data de inicio da coleção for maior que a data atual, atualizar a data de inicio da coleção para hoje*/
/*Trigger caso esteja tentando adicionar item a coleção, mas ela esteja marcada como completa, lançar uma mensagem de erro*/