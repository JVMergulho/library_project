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

-- Listar todos os livros registrados pela funcionária Leticia Pedrosa
SELECT DEREF(L.LivroInfo).ISBN, DEREF(L.LivroInfo).Titulo
FROM Livro L
WHERE L.Funcionario = (SELECT REF(F) FROM Funcionario F WHERE F.Nome = 'Leticia Pedrosa');

CREATE OR REPLACE FUNCTION varray_to_string(phones TelefonesType)
RETURN VARCHAR2
IS
    v_result VARCHAR2(1000);
BEGIN
    IF phones IS NULL OR phones.count = 0 THEN
        RETURN NULL;
    END IF;

    FOR i IN 1 .. phones.count LOOP
        IF i > 1 THEN
            v_result := v_result || ', ';
        END IF;
        v_result := v_result || phones(i);
    END LOOP;

    RETURN v_result;
END;
/

-- Para todos os emprestimos feitos em um mês retornar a data de emprestimo, de devolução e telefones
SELECT 
    E.DataEmprestimo, 
    E.DataDevolucao, 
    varray_to_string(DEREF(E.Leitor).Telefones) AS Telefones
FROM Emprestimo E
WHERE EXTRACT(MONTH FROM E.DataEmprestimo) = 1;

-- Mostra um telefone para cada pessoa que tem um telefone cadastrado
SELECT 
    P.Nome,
    T.COLUMN_VALUE AS Telefone
FROM 
    Pessoa P,
    TABLE(P.Telefones) T;

-- Lista teletones de pessoas que fizeram emprestimo em outubro
SELECT 
    E.DataEmprestimo, 
    E.DataDevolucao, 
    varray_to_string(DEREF(E.Leitor).Telefones) AS Telefones
FROM 
    Emprestimo E
WHERE 
    EXTRACT(MONTH FROM E.DataEmprestimo) = 10;

-- Listar livros com mais de um autor
SELECT 
    LI.ISBN,
    LI.Titulo,
    CARDINALITY(LI.Autores) AS NumeroDeAutores
FROM 
    LivroInfo LI
WHERE 
    CARDINALITY(LI.Autores) > 1;
