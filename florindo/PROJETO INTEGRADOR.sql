CREATE DATABASE Delicias_tia_tuti_DB;

USE Delicias_tia_tuti_DB;

-- ENTIDADES

CREATE TABLE usuario (
	id_user INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	email VARCHAR(75) NOT NULL UNIQUE,
	senha VARCHAR(255) NOT NULL,
	genero VARCHAR(10) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	telefone VARCHAR(14) NOT NULL UNIQUE,
	cidade VARCHAR(100) NOT NULL,
	estado VARCHAR(30) NOT NULL
);

CREATE TABLE encomenda (
	id_encomenda INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	status VARCHAR(15) NOT NULL,
	data_encomenda DATE NOT NULL,
	valor_total DECIMAL(10, 2) NOT NULL,
	quantidade INT NOT NULL,
	previsao_entrega TIMESTAMP NOT NULL 
);

CREATE TABLE sabor_tamanho (
	id_sabor_tamanho INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nome VARCHAR(25) NOT NULL,
	tamanho DOUBLE NOT NULL
);

CREATE TABLE produto (
	id_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	peso DOUBLE NOT NULL,
	tipo VARCHAR(25) NOT NULL,
	preco DECIMAL(10, 2) NOT NULL,
	data_fabricacao DATE NOT NULL,
	sob_encomenda BOOLEAN NOT NULL
);

CREATE TABLE producao (
	id_producao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	embalagem VARCHAR(25) NOT NULL,
	quantidade INT NOT NULL,
	status VARCHAR(15) NOT NULL,
	data_producao DATE NOT NULL
);

CREATE TABLE funcionario (
	id_funcionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cep VARCHAR(9) NOT NULL,
	salario DECIMAL(10, 2) NOT NULL,
	telefone VARCHAR(14) NOT NULL UNIQUE,
	rg VARCHAR(12) NOT NULL UNIQUE,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	data_nascimento DATE NOT NULL
);

CREATE TABLE formas_pagamento (
	id_formas_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL,
	data_insercao DATE NOT NULL
);

-- RELACOES

-- Relacao entre usuario e encomenda

CREATE TABLE solicita_encomenda (
	id_solicita_encomenda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_user INT NOT NULL,
	id_encomenda INT NOT NULL,

	FOREIGN KEY (id_user) REFERENCES usuario(id_user),
	FOREIGN KEY (id_encomenda) REFERENCES encomenda(id_encomenda)
);

-- Relacao entre encomenda e forma de pagamento
CREATE TABLE pagamento_encomenda(
	id_pagamento_encomenda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_formas_pagamento INT NOT NULL,
	id_encomenda INT NOT NULL,
	
	FOREIGN KEY (id_formas_pagamento) REFERENCES formas_pagamento(id_formas_pagamento),
	FOREIGN KEY (id_encomenda) REFERENCES encomenda(id_encomenda)
);

-- Relacao entre encomenda e produto

CREATE TABLE item_encomenda (
	id_item_encomenda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_encomenda INT NOT NULL,
	id_produto INT NOT NULL,
	
	FOREIGN KEY (id_encomenda) REFERENCES encomenda(id_encomenda),
	FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Relacao entre produto e sabor_tamanho
CREATE TABLE opcao_produto (
	id_opcao_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_sabor_tamanho INT NOT NULL,
	id_produto INT NOT NULL,
	
	FOREIGN KEY (id_sabor_tamanho) REFERENCES sabor_tamanho(id_sabor_tamanho),
	FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Relacao entre produto e produção

CREATE TABLE ordem_producao (
	id_ordem_producao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	data_fabricacao DATE NOT NULL,
	lista_fabricacao VARCHAR(25) NOT NULL,
	prioridade VARCHAR(20) NOT NULL,
	id_produto INT NOT NULL,
	id_funcionario INT NOT NULL,

	FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

-- Relação entre produção e funcionário

CREATE TABLE alocacao (
	id_alocacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	cargo VARCHAR(50) NOT NULL,
	id_producao INT NOT NULL,
	id_funcionario INT NOT NULL,

	FOREIGN KEY (id_producao) REFERENCES producao(id_producao),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);


-- Meu comentario:
-- Todas as entidades que possuem campos relacionados a dinheiro, eu deixei como "DECIMAL" para nao ter perigo do valor se arredondado pelo float ou double



-- POPULACAO DAS ENTIDADES

INSERT INTO usuario (nome, email, senha, genero, cpf, telefone, cidade, estado) VALUES
('Juliana Oliveira', 'juliana.oliveira@email.com', '7H}G419Bg}%:', 'Feminino', '61836725917', '11962814829', 'São Paulo', 'São Paulo'),
('Lucas Santos', 'lucas.santos@email.com', '18yfN9O[?1Wd', 'Masculino', '68130263586', '31905964940', 'Belo Horizonte', 'Minas Gerais'),
('Gabriela Almeida', 'gabriela.almeida@email.com', '4V[0*YYby8/,', 'Feminino', '41291617483', '41920025291', 'Curitiba', 'Paraná'),
('João Ferreira', 'joão.ferreira@email.com', 'nyzh7g$Wo53d', 'Masculino', '84136479358', '85922432618', 'Fortaleza', 'Ceará'),
('Fernanda Santos', 'fernanda.santos@email.com', 'J-s&p4*D34q&', 'Feminino', '38284892959', '11914665395', 'São Paulo', 'São Paulo'),
('Henrique Lima', 'henrique.lima@email.com', 'f_{67?b7Kpb~', 'Masculino', '53879675390', '81971161176', 'Recife', 'Pernambuco'),
('Beatriz Martins', 'beatriz.martins@email.com', 'WeP^42oy-6n0', 'Feminino', '16025824129', '71962842846', 'Salvador', 'Bahia'),
('Carlos Souza', 'carlos.souza@email.com', '5y*BR8;6.2r9', 'Masculino', '39106092868', '11986816208', 'São Paulo', 'São Paulo'),
('Isabela Costa', 'isabela.costa@email.com', 'y12wXX44w9l"', 'Feminino', '31287083566', '92986523615', 'Manaus', 'Amazonas'),
('Igor Almeida', 'igor.almeida@email.com', 'Y!@3+<mZ46+v', 'Masculino', '31389528981', '91968162149', 'Belém', 'Pará'),
('Carla Silva', 'carla.silva@email.com', '94`E%?phG4--', 'Feminino', '31049412780', '84925701447', 'Natal', 'Rio Grande do Norte'),
('Gustavo Costa', 'gustavo.costa@email.com', '/y%O30@£7eh<', 'Masculino', '28728910433', '27961543614', 'Vitória', 'Espírito Santo'),
('Helena Santos', 'helena.santos@email.com', 'hRw259f<Q0r@', 'Feminino', '93301576536', '82907484553', 'Maceió', 'Alagoas'),
('Diego Oliveira', 'diego.oliveira@email.com', 'S11|3jG&mlI2', 'Masculino', '76796319895', '98964929693', 'São Luís', 'Maranhão'),
('Daniela Ferreira', 'daniela.ferreira@email.com', 't4~rR36M;b.9', 'Feminino', '58760810814', '48947311268', 'Florianópolis', 'Santa Catarina'),
('Bruno Lima', 'bruno.lima@email.com', 'kG1`7XwN{&15', 'Masculino', '50564365366', '67926387063', 'Campo Grande', 'Mato Grosso do Sul'),
('Ana Costa', 'ana.costa@email.com', '0EkJ&kX0=MC6', 'Feminino', '52131828901', '11984477266', 'São Paulo', 'São Paulo'),
('Felipe Souza', 'felipe.souza@email.com', '00!}4YSy`47?', 'Masculino', '32430782734', '83993615541', 'João Pessoa', 'Paraíba'),
('Elisa Santos', 'elisa.santos@email.com', '501@@[j9E30l', 'Feminino', '80622290226', '71951379417', 'Salvador', 'Bahia'),
('Eduardo Lima', 'eduardo.lima@email.com', '"0uB94F9uSo', 'Masculino', '38780562139', '63994769579', 'Palmas', 'Tocantins');


INSERT INTO encomenda (status, data_encomenda, valor_total, quantidade, previsao_entrega) VALUES 
('Pendente',   '2025-05-18', 263.57,  6, '2025-05-29 05:25:24'),
('Enviada',    '2025-03-13', 321.08,  3, '2025-05-23 03:43:44'),
('Enviada',    '2025-04-25', 240.53,  9, '2025-05-29 04:32:56'),
('Confirmada', '2025-05-07', 222.16, 10, '2025-05-29 13:23:14'),
('Cancelada',  '2025-01-11', 427.52,  9, '2025-05-27 20:32:58'),
('Confirmada', '2025-04-15', 408.76,  7, '2025-05-29 11:30:40'),
('Cancelada',  '2025-01-02', 400.81, 10, '2025-05-21 22:23:28'),
('Confirmada', '2025-04-07', 182.83,  4, '2025-05-23 12:07:51'),
('Pendente',   '2025-03-23',  53.39, 10, '2025-05-26 08:01:41'),
('Pendente',   '2025-02-09', 301.81,  2, '2025-05-23 06:23:11'),
('Enviada',    '2025-04-24', 139.89, 10, '2025-05-27 20:26:02'),
('Confirmada', '2025-04-10', 159.76,  7, '2025-05-21 23:02:55'),
('Pendente',   '2025-03-18', 499.85,  4, '2025-05-26 00:28:19'),
('Cancelada',  '2025-04-11', 303.75,  8, '2025-05-26 23:06:59'),
('Enviada',    '2025-03-24', 308.24,  9, '2025-05-23 02:36:10'),
('Confirmada', '2025-02-22', 361.52,  7, '2025-05-29 09:11:01'),
('Cancelada',  '2025-01-22', 432.74,  5, '2025-05-23 06:20:48'),
('Enviada',    '2025-03-17', 111.61,  4, '2025-05-28 11:00:07'),
('Enviada',    '2025-05-18', 360.23,  6, '2025-05-21 01:30:40'),
('Confirmada', '2025-03-13', 424.38,  7, '2025-05-23 13:36:59');


INSERT INTO sabor_tamanho (nome, tamanho) VALUES
('Chocolate 1', 1.1),
('Abacaxi 2', 0.7),
('Nozes 3', 0.7),
('Nozes 4', 1.2),
('Doce de leite 5', 0.5),
('Coco 6', 1.1),
('Nozes 7', 1.9),
('Cenoura 8', 0.6),
('Cenoura 9', 2.4),
('Doce de leite 10', 0.8),
('Abacaxi 11', 0.9),
('Doce de leite 12', 0.6),
('Nozes 13', 0.6),
('Nozes 14', 0.7),
('Limão 15', 1.0),
('Limão 16', 2.1),
('Maracujá 17', 0.7),
('Limão 18', 2.4),
('Doce de leite 19', 0.8),
('Baunilha 20', 0.7);


INSERT INTO produto (peso, tipo, preco, data_fabricacao, sob_encomenda) VALUES
(1.69, 'Torta', 38.38, '2025-03-08', 1),
(2.23, 'Torta', 36.39, '2025-03-29', 0),
(1.64, 'Torta', 47.18, '2025-03-10', 0),
(1.81, 'Pudim', 14.89, '2025-03-20', 0),
(1.83, 'Brigadeiro', 88.76, '2025-01-01', 0),
(0.91, 'Torta', 26.07, '2025-04-24', 1),
(2.48, 'Brigadeiro', 78.83, '2025-04-05', 1),
(2.92, 'Bolo', 29.32, '2025-01-30', 0),
(0.92, 'Pudim', 77.01, '2025-02-22', 1),
(0.57, 'Torta', 77.33, '2025-03-18', 0),
(0.75, 'Torta', 43.28, '2025-03-12', 1),
(1.22, 'Pudim', 68.53, '2025-03-05', 0),
(1.58, 'Pudim', 69.98, '2025-05-11', 0),
(1.59, 'Bolo', 30.54, '2025-01-14', 1),
(1.67, 'Pudim', 15.47, '2025-01-26', 0),
(1.27, 'Pudim', 32.62, '2025-04-09', 0),
(1.14, 'Bolo', 85.62, '2025-04-07', 1),
(1.81, 'Pudim', 85.29, '2025-04-30', 1),
(1.21, 'Bolo', 53.98, '2025-04-13', 0),
(0.82, 'Pudim', 86.42, '2025-05-15', 0);


INSERT INTO producao (embalagem, quantidade, status, data_producao) VALUES
('Saco', 50, 'Pendente', '2025-04-12'),
('Caixa', 96, 'Em produção', '2025-05-15'),
('Papel Alumínio', 97, 'Produzido', '2025-04-22'),
('Plástico', 100, 'Produzido', '2025-05-17'),
('Saco', 86, 'Pendente', '2025-05-03'),
('Caixa', 88, 'Pendente', '2025-02-17'),
('Saco', 22, 'Pendente', '2025-01-08'),
('Saco', 7, 'Produzido', '2025-02-28'),
('Plástico', 61, 'Pendente', '2025-03-19'),
('Caixa', 16, 'Produzido', '2025-05-04'),
('Plástico', 32, 'Pendente', '2025-04-28'),
('Papel Alumínio', 94, 'Pendente', '2025-02-22'),
('Plástico', 24, 'Pendente', '2025-02-27'),
('Caixa', 90, 'Pendente', '2025-01-21'),
('Caixa', 16, 'Produzido', '2025-03-26'),
('Plástico', 44, 'Pendente', '2025-01-20'),
('Caixa', 80, 'Produzido', '2025-05-15'),
('Plástico', 45, 'Pendente', '2025-01-18'),
('Papel Alumínio', 12, 'Produzido', '2025-04-23'),
('Plástico', 66, 'Em produção', '2025-04-24');


INSERT INTO funcionario (nome, cep, salario, telefone, rg, cpf, data_nascimento) VALUES 
('Ana Oliveira', '88640-242', 2319.54, '81988058341', '559875357', '90178432687', '1969-01-18'),
('Carlos Souza', '34378-446', 2010.21, '31961496125', '944339814', '73096148287', '1994-03-21'),
('Mariana Lima', '20044-588', 3972.55, '61918912687', '765075230', '48716520920', '2000-11-03'),
('Rafael Costa', '48240-899', 1500.12, '81916942685', '135194567', '54081269785', '1970-09-24'),
('Juliana Almeida', '91222-583', 3205.02, '84902590211', '303242506', '18539274655', '1974-04-26'),
('Eduardo Martins', '87881-752', 3999.09, '41916680705', '216120616', '75690432199', '1978-10-21'),
('Fernanda Ribeiro', '42548-852', 3963.95, '9006389381', '661140841', '29170683530', '1979-12-31'),
('Lucas Pereira', '05284-183', 2280.89, '21919648346', '355237133', '60829735429', '1995-06-30'),
('Bianca Fernandes', '42920-098', 2036.73, '8009240195', '241064161', '78652931003', '1976-09-27'),
('Mateus Rocha', '40666-329', 4363.61, '51931305987', '450345272', '26137048535', '1973-09-18'),
('Patrícia Nogueira', '35234-194', 3068.95, '41939529259', '346612083', '09157826420', '1972-10-19'),
('Vinícius Teixeira', '95310-985', 1577.98, '81977781553', '320409021', '03189567212', '2001-10-05'),
('Camila Monteiro', '78312-239', 2535.33, '81906081630', '114125582', '86412095730', '1988-10-01'),
('Renato Barros', '97796-395', 2534.75, '51992876373', '103241300', '87105349204', '1995-03-31'),
('André Farias', '40170-780', 4347.81, '11920705787', '771138626', '41092875379', '1964-08-13'),
('Isabela Cardoso', '40323-056', 3552.48, '11957311595', '930341522', '43916852728', '1984-04-15'),
('Gabriel Lopes', '63068-075', 2312.86, '71965216099', '292103256', '67132598473', '1974-02-07'),
('Larissa Santos', '03588-878', 3115.49, '31940705089', '157899617', '87403692187', '1974-06-02'),
('Danilo Mendes', '01890-358', 2187.65, '81936259924', '620045690', '08569432747', '2001-04-19'),
('Tatiane Silva', '11874-413', 3492.33, '11919433106', '290349365', '65893472047', '1978-08-18');



-- POPULACAO DOS RELACIONAMENTOS

INSERT INTO formas_pagamento (tipo, data_insercao) VALUES
('Crédito', '2025-03-28'),
('PIX', '2025-02-28'),
('Boleto', '2025-01-30'),
('Dinheiro', '2025-03-20'),
('Crédito', '2025-03-06'),
('PIX', '2025-02-13'),
('Dinheiro', '2025-03-22'),
('PIX', '2025-04-27'),
('Débito', '2025-05-17'),
('Débito', '2025-01-22'),
('Crédito', '2025-04-23'),
('Dinheiro', '2025-03-20'),
('Crédito', '2025-04-13'),
('Dinheiro', '2025-02-07'),
('Dinheiro', '2025-03-27'),
('Débito', '2025-03-15'),
('Crédito', '2025-03-11'),
('Boleto', '2025-03-31'),
('PIX', '2025-05-13'),
('Débito', '2025-04-21');


INSERT INTO solicita_encomenda (id_user, id_encomenda) VALUES
(2, 5),
(2, 5),
(9, 16),
(6, 9),
(12, 3),
(18, 5),
(19, 11),
(19, 8),
(4, 19),
(6, 11),
(18, 2),
(10, 12),
(15, 3),
(16, 9),
(16, 8),
(4, 4),
(2, 19),
(15, 1),
(16, 18),
(2, 17);


INSERT INTO pagamento_encomenda (id_formas_pagamento, id_encomenda) VALUES
(2, 17),
(15, 19),
(2, 9),
(16, 6),
(20, 13),
(4, 6),
(11, 8),
(9, 16),
(15, 1),
(14, 6),
(5, 17),
(19, 1),
(7, 16),
(13, 18),
(16, 9),
(5, 20),
(11, 2),
(2, 2),
(17, 3),
(9, 12);


INSERT INTO item_encomenda (id_encomenda, id_produto) VALUES
(15, 9),
(11, 6),
(2, 6),
(13, 17),
(3, 14),
(15, 14),
(17, 10),
(4, 3),
(12, 19),
(14, 8),
(6, 19),
(12, 15),
(10, 17),
(8, 7),
(6, 10),
(18, 8),
(20, 4),
(19, 15),
(9, 19),
(12, 15);


INSERT INTO opcao_produto (id_sabor_tamanho, id_produto) VALUES
(7, 4),
(4, 9),
(12, 5),
(3, 18),
(1, 18),
(18, 18),
(20, 8),
(16, 11),
(18, 6),
(3, 6),
(18, 1),
(9, 19),
(12, 2),
(17, 14),
(5, 14),
(8, 12),
(4, 6),
(14, 5),
(13, 4),
(13, 3);


INSERT INTO ordem_producao (data_fabricacao, lista_fabricacao, prioridade, id_produto, id_funcionario) VALUES
('2025-02-03', 'Lote 1', 'Alta', 11, 19),
('2025-01-24', 'Lote 2', 'Baixa', 12, 16),
('2025-04-03', 'Lote 3', 'Média', 11, 19),
('2025-04-18', 'Lote 4', 'Alta', 5, 12),
('2025-01-09', 'Lote 5', 'Média', 4, 13),
('2025-01-26', 'Lote 6', 'Alta', 11, 5),
('2025-03-07', 'Lote 7', 'Baixa', 7, 4),
('2025-04-17', 'Lote 8', 'Alta', 19, 8),
('2025-02-08', 'Lote 9', 'Média', 8, 2),
('2025-02-06', 'Lote 10', 'Alta', 14, 13),
('2025-03-12', 'Lote 11', 'Alta', 20, 2),
('2025-03-26', 'Lote 12', 'Baixa', 15, 2),
('2025-01-09', 'Lote 13', 'Alta', 3, 3),
('2025-01-15', 'Lote 14', 'Baixa', 11, 7),
('2025-05-06', 'Lote 15', 'Média', 7, 19),
('2025-03-31', 'Lote 16', 'Média', 18, 14),
('2025-01-09', 'Lote 17', 'Baixa', 12, 5),
('2025-04-17', 'Lote 18', 'Baixa', 5, 12),
('2025-05-06', 'Lote 19', 'Alta', 12, 16),
('2025-05-12', 'Lote 20', 'Alta', 1, 14);


INSERT INTO alocacao (cargo, id_producao, id_funcionario) VALUES
('Gerente', 15, 8),
('Gerente', 19, 6),
('Padeiro', 15, 20),
('Auxiliar', 9, 10),
('Padeiro', 1, 12),
('Auxiliar', 15, 15),
('Padeiro', 7, 5),
('Confeiteiro', 4, 1),
('Gerente', 3, 17),
('Auxiliar', 7, 1),
('Confeiteiro', 10, 7),
('Gerente', 11, 8),
('Padeiro', 10, 1),
('Confeiteiro', 17, 20),
('Auxiliar', 20, 2),
('Auxiliar', 1, 4),
('Padeiro', 2, 15),
('Confeiteiro', 18, 14),
('Padeiro', 11, 5),
('Padeiro', 18, 8);


-- TODAS AS CONSULTAS


-- Visualizando todas as entidades (tirando campos como id, e senha para deixa pronto para a visualizacao em um site ou app por exemplo)
SELECT nome, email, genero, cpf, telefone, cidade, estado FROM usuario;
SELECT status, data_encomenda, valor_total, quantidade, previsao_entrega FROM encomenda;
SELECT tipo, data_insercao FROM formas_pagamento;
SELECT peso, tipo, preco, data_fabricacao, sob_encomenda FROM produto;
SELECT nome, tamanho FROM sabor_tamanho;
SELECT embalagem, quantidade, status, data_producao FROM producao;
SELECT nome, cep, salario, telefone, rg, cpf, data_nascimento FROM funcionario;



-- CONSULTAS SIMPLES (SEM JOIN TABLE)

-- Selecionando usuarios que moram na cidade de Sao paulo
SELECT nome, email, genero, telefone, cidade, estado 
FROM usuario 
WHERE cidade = 'São Paulo';

-- Selecionando usuarios que moram na cidade de Belo Horizonte
SELECT nome, email, genero, telefone, cidade, estado 
FROM usuario 
WHERE cidade = 'Belo Horizonte';

-- Selecionando apenas usuarios do sexo feminino
SELECT nome, email, genero, telefone, cidade, estado 
FROM usuario 
WHERE genero = 'Feminino';

-- Selecionando apenas usuarios do sexo masculino
SELECT nome, email, genero, telefone, cidade, estado 
FROM usuario 
WHERE genero = 'Masculino';

-- Selecionando apenas produtos sob encomenda
SELECT id_produto, tipo, preco
FROM produto
WHERE sob_encomenda = TRUE;

-- Contando cada tipo de produto
SELECT tipo, COUNT(*) AS quantidade
FROM produto
GROUP BY tipo;

-- Selecionando podutos com preço acima de 50 reais
SELECT * FROM produto WHERE preco > 50;

-- Selecionando todas encomendas com status em "pendente"
SELECT * FROM encomenda WHERE status = "Pendente";

-- Selecionando todas encomendas com status em "enviada"
SELECT * FROM encomenda WHERE status = "Enviada";

-- Selecionando todas encomendas com status em "cancelada"
SELECT * FROM encomenda WHERE status = "Cancelada";

-- Selecionando todas encomendas com status em "confirmada"
SELECT * FROM encomenda WHERE status = "Confirmada";

-- Seleciona todos os funcionarios com o salario acima de 3000 reais
SELECT nome, salario FROM funcionario WHERE salario > 3000;

-- Seleciona todas as encomendas com o valor acima de 100 reais
SELECT id_encomenda, status, valor_total, quantidade from encomenda WHERE valor_total > 100;


-- CONSULTAS COMPLEXAS (COM JOIN TABLE)

-- Agrupando o usuário e seus pedidos
SELECT u.nome, e.id_encomenda, e.status, e.valor_total, e.previsao_entrega
FROM usuario u
JOIN solicita_encomenda se ON u.id_user = se.id_user
JOIN encomenda e ON se.id_encomenda = e.id_encomenda
WHERE u.nome = "Lucas Santos";

-- Mostra o total que cada usuario ja gastou
-- Usando SUM() para somar todos os "valor_total" de "encomenda"
SELECT u.nome, SUM(e.valor_total) AS total_gasto
FROM usuario u
JOIN solicita_encomenda se ON u.id_user = se.id_user
JOIN encomenda e ON se.id_encomenda = e.id_encomenda
GROUP BY u.nome
ORDER BY total_gasto DESC;

-- Seleciona todos os funcionarios envolvidos em uma produção
SELECT f.nome, a.cargo, p.status, p.data_producao
FROM funcionario f
JOIN alocacao a ON f.id_funcionario = a.id_funcionario
JOIN producao p ON a.id_producao = p.id_producao
WHERE p.id_producao = 1;

-- Produtos produzidos por cada funcionario
SELECT f.nome as 'Nome funcionario', p.tipo, op.prioridade, op.data_fabricacao
FROM funcionario f
JOIN ordem_producao op ON f.id_funcionario = op.id_funcionario
JOIN produto p ON op.id_produto = p.id_produto;
