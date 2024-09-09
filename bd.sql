CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2)
);

CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT,
    Quantidade INT,
    DataPedido DATE,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

DELIMITER //

CREATE PROCEDURE RelatorioVendasPorDia(IN data DATE)
BEGIN
    SELECT P.NomeProduto, SUM(PD.Quantidade) AS QuantidadeVendida
    FROM Pedidos PD
    JOIN Produtos P ON PD.ProdutoID = P.ProdutoID
    WHERE PD.DataPedido = data
    GROUP BY P.NomeProduto
    ORDER BY QuantidadeVendida DESC;
END; //

DELIMITER ;

CALL RelatorioVendasPorDia('2024-09-09');
