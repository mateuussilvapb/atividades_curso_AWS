CREATE DATABASE Escola;
USE Escola;

CREATE TABLE Estudantes (
    EstudanteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Idade INT,
    Genero VARCHAR(10)
);

CREATE TABLE Cursos (
    CursoID INT AUTO_INCREMENT PRIMARY KEY,
    NomeCurso VARCHAR(100),
    Descricao VARCHAR(255)
);

CREATE TABLE Matriculas (
    MatriculaID INT AUTO_INCREMENT PRIMARY KEY,
    EstudanteID INT,
    CursoID INT,
    DataMatricula DATE,
    FOREIGN KEY (EstudanteID) REFERENCES Estudantes(EstudanteID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);

INSERT INTO Estudantes (Nome, Idade, Genero) VALUES 
('João Silva', 20, 'Masculino'),
('Maria Oliveira', 22, 'Feminino'),
('Carlos Santos', 19, 'Masculino'),
('Ana Souza', 21, 'Feminino');

INSERT INTO Cursos (NomeCurso, Descricao) VALUES 
('Matemática', 'Curso de Matemática Básica e Avançada'),
('História', 'Curso de História Mundial e Nacional'),
('Programação', 'Curso de Programação em diversas linguagens'),
('Inglês', 'Curso de Inglês para todos os níveis');

INSERT INTO Matriculas (EstudanteID, CursoID, DataMatricula) VALUES 
(1, 1, '2024-01-15'),
(1, 3, '2024-01-20'),
(2, 2, '2024-02-10'),
(3, 3, '2024-02-12'),
(4, 1, '2024-01-17'),
(4, 4, '2024-02-01');

SELECT nome, idade FROM Estudantes
LEFT JOIN Matriculas
ON Estudantes.EstudanteID = Matriculas.EstudanteID;

SELECT estudanteid, datamatricula FROM Matriculas
RIGHT JOIN Cursos
On Cursos.CursoID = Matriculas.CursoID;

SELECT nome, idade FROM Estudantes
INNER JOIN Matriculas
ON Estudantes.EstudanteID = Matriculas.MatriculaID;

SELECT * from Matriculas
LEFT JOIN Estudantes
On Matriculas.EstudanteID = Estudantes.EstudanteID
UNION
SELECT * from Matriculas
RIGHT JOIN Estudantes
On Matriculas.EstudanteID = Estudantes.EstudanteID;
