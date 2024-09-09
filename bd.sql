CREATE DATABASE Loja;
USE Loja;

CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Telefone VARCHAR(15)
);

CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2),
    Estoque INT
);

CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    ProdutoID INT,
    Quantidade INT,
    DataPedido DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

DELIMITER //

CREATE TRIGGER AtualizaEstoque AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    DECLARE novaQuantidade INT;
    -- Calcula a nova quantidade de estoque após o pedido
    SET novaQuantidade = (SELECT Estoque FROM Produtos WHERE ProdutoID = NEW.ProdutoID) - NEW.Quantidade;

    -- Verifica se há estoque suficiente
    IF novaQuantidade >= 0 THEN
        -- Atualiza o estoque do produto
        UPDATE Produtos SET Estoque = novaQuantidade WHERE ProdutoID = NEW.ProdutoID;
    ELSE
        -- Caso não haja estoque suficiente, gera um erro e cancela o pedido
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto!';
    END IF;
END; //

DELIMITER ;
