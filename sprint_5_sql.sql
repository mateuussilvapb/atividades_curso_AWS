-- INÍCIO CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE VENDA_JOGOS;
USE VENDA_JOGOS;
-- FIM CRIAÇÃO DO BANCO DE DADOS

-- INÍCIO CRIAÇÃO TABELAS
CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    nomeUsuario VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    dataNascimento DATE NOT NULL
);

CREATE TABLE endereco (
	id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(2) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero INT,
    id_fk_usuario INT UNIQUE,
    FOREIGN KEY (id_fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE contato (
	id_contato INT AUTO_INCREMENT PRIMARY KEY,
    tipo_contato ENUM('TELEFONE', 'EMAIL') NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    id_fk_usuario INT,
    FOREIGN KEY (id_fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE pedido(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    id_fk_usuario INT,
    FOREIGN KEY (id_fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE jogo(
	id_jogo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    data_lancamento DATE NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pedido_jogo(
	id_pedido INT,
    id_jogo INT,
    PRIMARY KEY (id_pedido, id_jogo),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo)
);
-- FIM CRIAÇÃO TABELAS

-- INÍCIO INSERÇÃO DADOS
-- Inserindo dados na tabela `usuario`
INSERT INTO usuario (nome, nomeUsuario, cpf, dataNascimento) VALUES
('João Silva', 'joaosilva', '12345678901', '1985-01-15'),
('Maria Oliveira', 'mariaoliveira', '23456789012', '1992-06-24'),
('Mateus Dias', 'mssousa', '32112332123', '1997-03-05'),
('Carlos Souza', 'carlossouza', '34567890123', '1978-11-02');

-- Inserindo dados na tabela `endereco`
INSERT INTO endereco (estado, cidade, bairro, logradouro, numero, id_fk_usuario) VALUES
('SP', 'São Paulo', 'Centro', 'Rua A', 123, 1),
('RJ', 'Rio de Janeiro', 'Copacabana', 'Avenida Atlântica', 456, 2),
('MG', 'Belo Horizonte', 'Savassi', 'Rua da Bahia', 789, 3);

-- Inserindo dados na tabela `contato`
INSERT INTO contato (tipo_contato, descricao, id_fk_usuario) VALUES
('TELEFONE', '(11) 98765-4321', 1),
('EMAIL', 'joao.silva@example.com', 1),
('TELEFONE', '(21) 91234-5678', 2),
('EMAIL', 'maria.oliveira@example.com', 2),
('TELEFONE', '(31) 99876-5432', 3),
('EMAIL', 'carlos.souza@example.com', 3);

-- Inserindo dados na tabela `jogo`
INSERT INTO jogo (titulo, data_lancamento, descricao, valor) VALUES
('The Legend of SQL', '2020-05-10', 'Um jogo de aventura que explora o mundo das bases de dados.', 199.99),
('Data Warriors', '2021-07-15', 'Um RPG onde os heróis são cientistas de dados.', 149.99),
('AI Invaders', '2019-03-25', 'Um jogo de estratégia sobre inteligência artificial dominando o mundo.', 99.99),
('Cyber Queries', '2022-01-05', 'Ação frenética em um mundo distópico onde consultas SQL são a lei.', 249.99),
('GTA VI', '2026-01-05', 'Ação.', 349.99);

-- Inserindo dados na tabela `pedido`
INSERT INTO pedido (data_pedido, id_fk_usuario) VALUES
('2023-01-10', 1),
('2023-02-15', 1),
('2023-03-20', 2),
('2023-04-25', 3),
('2023-05-30', 3);

-- Inserindo dados na tabela `pedido_jogo`
INSERT INTO pedido_jogo (id_pedido, id_jogo) VALUES
(1, 1),  -- Pedido 1, Jogo 1
(1, 2),  -- Pedido 1, Jogo 2
(2, 3),  -- Pedido 2, Jogo 3
(3, 2),  -- Pedido 3, Jogo 2
(3, 4),  -- Pedido 3, Jogo 4
(4, 1),  -- Pedido 4, Jogo 1
(5, 1),  -- Pedido 5, Jogo 1
(5, 4);  -- Pedido 5, Jogo 4
-- FIM INSERÇÃO DADOS

-- INÍCIO EXEMPLOS SELECT
-- Título, Data de Lançamento e Data de Compra de Todos os Jogos, com exceção dos jogos não vendidos. (Usando INNER JOIN)
SELECT 
    j.titulo AS titulo_jogo, 
    j.data_lancamento AS data_lancamento_jogo, 
    p.data_pedido AS data_compra
FROM pedido_jogo pj
INNER JOIN pedido p ON pj.id_pedido = p.id_pedido
INNER JOIN jogo j ON pj.id_jogo = j.id_jogo;

-- Todos os jogos, valores, datas de lançamento e datas de pedido, incluindo jogos que ainda não tiveram nenhum pedido.
SELECT
	j.titulo AS titulo_jogo,
    j.valor AS valor_jogo,
    j.data_lancamento AS lancamento_jogo,
    p.data_pedido AS data_pedido
FROM pedido_jogo pj
RIGHT JOIN jogo j ON j.id_jogo = pj.id_jogo
LEFT JOIN pedido p ON pj.id_pedido = p.id_pedido;

-- Todos os Usuários e Seus Pedidos, Incluindo Usuários Sem Pedidos (Usando LEFT JOIN)
SELECT 
    u.nome AS nome_usuario,
    p.id_pedido AS numero_pedido,
    p.data_pedido AS data_pedido
FROM usuario u
LEFT JOIN pedido p ON u.id_usuario = p.id_fk_usuario;

-- Todos os Pedidos, Jogos Relacionados e data de lançamento (Usando LEFT JOIN)
SELECT 
    p.id_pedido AS numero_pedido,
    j.titulo AS titulo_jogo,
    j.data_lancamento AS data_lancamento_jogo
FROM pedido p
LEFT JOIN pedido_jogo pj ON p.id_pedido = pj.id_pedido
LEFT JOIN jogo j ON pj.id_jogo = j.id_jogo;

-- Todos os Contatos dos Usuários e Pedidos Correspondentes
SELECT 
    c.descricao AS contato,
    u.nome AS nome_usuario,
    p.id_pedido AS numero_pedido
FROM contato c
LEFT JOIN usuario u ON c.id_fk_usuario = u.id_usuario
LEFT JOIN pedido p ON u.id_usuario = p.id_fk_usuario;
-- FIM EXEMPLOS SELECT