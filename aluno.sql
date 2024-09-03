CREATE DATABASE ESCOLA;
USE ESCOLA;
CREATE TABLE ALUNO (
    ID INT PRIMARY KEY AUTO_INCREMENT, -- Chave primária com auto incremento
    nome VARCHAR(255),  -- Atributo nome
    email VARCHAR(255), -- Atributo e-mail
    endereco VARCHAR(255) -- Atributo endereço
);
