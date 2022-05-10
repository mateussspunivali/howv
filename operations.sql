/*INSERTS*/
INSERT INTO estado (nome, uf) VALUES
('Acre', 'AC'),
('Alagoas', 'AL'),
('Amazonas', 'AM'),
('Amapá', 'AP'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Distrito Federal', 'DF'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Minas Gerais', 'MG'),
('Mato Grosso do Sul', 'MS'),
('Mato Grosso', 'MT'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Paraná', 'PR'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Rio Grande do Sul', 'RS'),
('Santa Catarina', 'SC'),
('Sergipe', 'SE'),
('São Paulo', 'SP'),
('Tocantins', 'TO');

INSERT INTO cidade (nome, id_estado) VALUES ('Navegantes', 24);

INSERT INTO endereco (logradouro, numero, bairro, cep, id_cidade) VALUES ('Rua XPTO', '123', 'Bairro teste', '11111-111', 1);

INSERT INTO endereco (logradouro, numero, bairro, cep, id_cidade) VALUES ('Rua teste', '123', 'Bairro teste', '22222-222', 1);

INSERT INTO colecionador (nome_completo, email, senha, id_endereco) VALUES ('Mateus da Silva Sanson Picoloto', 'mpicoloto@edu.univali.br', 'admin123', 1);

INSERT INTO colecionador (nome_completo, email, senha, id_endereco) VALUES ('João da Silva', 'teste@teste.com', 'admin123', 2);

INSERT INTO categoria (nome) VALUES ('Quadrinhos');

INSERT INTO colecao (nome, descricao, data_inicio, completa, id_colecionador, id_categoria) VALUES ('Quadrinhos do Batman', 'Coleções de quadrinhos do super herói Batman', '2010-01-22', 0, 1, 1);

INSERT INTO colecao (nome, descricao, data_inicio, completa, id_colecionador, id_categoria) VALUES ('Quadrinhos do Homem Aranha', 'Coleções de quadrinhos do super herói Homem Aranha', '2015-06-11', 0, 2, 1);

INSERT INTO itens_colecao (nome, descricao, imagem, id_colecao) VALUES ('Batman ano 1', 'Edição em excelente estado de conservação do Batman ano 1', 'caminho/da/imagem', 1);

INSERT INTO itens_colecao (nome, descricao, imagem, id_colecao) VALUES ('Batman cavaleiro das trevas', 'Edição com alguns detalhes na capa do Batman cavaleiro das trevas', 'caminho/da/imagem', 1);

INSERT INTO itens_colecao (nome, descricao, imagem, id_colecao) VALUES ('Batman silêncio', 'Edição em excelente estado de conservação do Batman silêncio', 'caminho/da/imagem', 1);

INSERT INTO itens_colecao (nome, descricao, imagem, id_colecao) VALUES ('Homem Aranha Saga dos Clones', 'Edições em excelente estado de conservação da Saga dos Clones do Homem Aranha', 'caminho/da/imagem', 2);

/*UPDATES*/
UPDATE colecao SET data_inicio = '2011-01-22' WHERE id = 1;

UPDATE itens_colecao SET descricao = 'Edição com danos em algumas páginas do Batman ano 1' WHERE id = 1;

UPDATE cidade SET nome = 'Itajaí' WHERE id = 1;

UPDATE endereco SET numero = '321' WHERE id = 1;

UPDATE colecionador SET nome_completo = 'John Doe' WHERE id = 2;

/*DELETES*/
DELETE from itens_colecao where id = 4;

DELETE from itens_colecao where id = 3;

DELETE from colecao where id = 2;

DELETE from colecionador where id = 2;

DELETE from endereco where id = 2;

/*SELECTS*/

SELECT * FROM colecionador where email = 'mpicoloto@edu.univali.br';

SELECT * FROM colecionador
INNER JOIN endereco ON colecionador.id_endereco = endereco.id
INNER JOIN cidade ON cidade.id = endereco.id_cidade
INNER JOIN estado ON estado.id = cidade.id_estado;

SELECT * FROM cidade
INNER JOIN estado ON estado.id = cidade.id_estado
WHERE estado.uf = 'SC';

SELECT itens_colecao.* FROM itens_colecao
INNER JOIN colecao ON colecao.id = itens_colecao.id_colecao
WHERE colecao.id_colecionador = 1;

SELECT * FROM colecao
INNER JOIN colecionador ON colecionador.id = colecao.id_colecionador
WHERE colecao.completa = 0;

SELECT * FROM colecao
INNER JOIN categoria ON categoria.id = colecao.id_categoria;

SELECT * FROM categoria WHERE nome != 'Moedas';

SELECT * FROM cidade WHERE id = 1;

SELECT * FROM estado WHERE nome = 'Bahia';

SELECT * FROM itens_colecao WHERE id_colecao = 1;