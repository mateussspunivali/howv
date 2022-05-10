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
    CONSTRAINT fk_endereco_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id)
);

CREATE TABLE colecionador (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(255),
    email VARCHAR(100),
    senha VARCHAR(255),
    id_endereco INT,
    CONSTRAINT fk_colecionador_endereco FOREIGN KEY (id_endereco) REFERENCES endereco (id)
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
DELIMITER ;;

CREATE PROCEDURE atualizar_data_inicio_colecao()
BEGIN
  DECLARE cursor_id INT;
  DECLARE cursor_data_inicio DATE;
  DECLARE finalizado INT DEFAULT FALSE;
  DECLARE cursor_i CURSOR FOR SELECT id, data_inicio FROM colecao;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finalizado = TRUE;
  OPEN cursor_i;
  read_loop: LOOP
    FETCH cursor_i INTO cursor_id, cursor_data_inicio;
    IF finalizado THEN
      LEAVE read_loop;
    END IF;
    IF cursor_data_inicio > CURDATE()  THEN
    	UPDATE colecao SET data_inicio = CURDATE() WHERE id = cursor_id;
    END IF;
  END LOOP;
  CLOSE cursor_i;
END;
;;

/*Trigger caso esteja tentando adicionar item a coleção, mas ela esteja marcada como completa, lançar uma mensagem de erro*/
DELIMITER $

CREATE TRIGGER trigger_bloqueio_insercao_caso_colecao_completa BEFORE INSERT
ON itens_colecao
FOR EACH ROW
BEGIN
	DECLARE colecao_completa INT;
    SELECT colecao.completa INTO colecao_completa FROM colecao WHERE colecao.id = NEW.id_colecao;
	IF colecao_completa THEN
    	SIGNAL SQLSTATE '45000' SET message_text = 'Coleção já completa, não podem ser inseridos novos itens nela!';
    END IF;
END;
$