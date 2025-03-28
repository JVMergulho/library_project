
-- CONSULTAS COM NESTED TABLE

-- Listar todos os livros com seus autores
SELECT L.ISBN, L.Titulo, A.Nome AS NomeAutor
FROM LivroInfo L, TABLE(L.Autores) A;

-- Listar todos os livros com seus generos
SELECT L.ISBN, L.Titulo, G.Nome AS Genero
FROM LivroInfo L, TABLE(L.Generos) G;

-- Listar todos os autores e a quantidade de livros em que cada um deles aparece
SELECT A.Nome AS NomeAutor, A.ID AS ID_Autor, COUNT(L.ISBN) AS QuantidadeLivros
FROM LivroInfo L, TABLE(L.Autores) A
GROUP BY A.ID, A.Nome
ORDER BY QuantidadeLivros DESC;

-- CONSULTAS COM VARRAY

-- Listar os telefones de todas as pessoas que fizeram empréstimos no mês de janeiro
SELECT 
    E.DataEmprestimo, 
    E.DataDevolucao, 
    T.COLUMN_VALUE AS Telefone
FROM 
    Emprestimo E,
    DEREF(E.Leitor) L,
    TABLE(L.Telefones) T
WHERE 
    EXTRACT(MONTH FROM E.DataEmprestimo) = 1;

-- CONSULTAS COM REF E DEREF

-- Listar todos os livros registrados pela funcionária Leticia Pedrosa
SELECT DEREF(L.LivroInfo).ISBN, DEREF(L.LivroInfo).Titulo
FROM Livro L
WHERE L.Funcionario = (SELECT REF(F) FROM Funcionario F WHERE F.Nome = 'Leticia Pedrosa');

-- Listar todos os livros atrasados
SELECT E.getLeitor(), E.DataEmprestimo, E.DataDevolucao, DEREF(E.Livro).Titulo
FROM Emprestimo E
WHERE E.Estado = 'A'
ORDER BY E.getLeitor();

-- Seção onde está o livro "O Pequeno Príncipe"
SELECT DEREF(L.secao).Nome
FROM LivroInfo L
WHERE L.NOME = 'O Pequeno Príncipe';

--  Listar todos os empréstimos com informações dos livros e membros
SELECT E.ID, DEREF(E.LivroInfo).Titulo, DEREF(E.Membro).Nome, E.DataEmprestimo, E.DataDevolucao
FROM Emprestimo E;