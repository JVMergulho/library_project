SELECT Titulo
FROM Livro
WHERE ISBN IN (SELECT ISBN FROM Emprestimo WHERE Estado = 'E');

SELECT Titulo, Preco
FROM LivroInfo
JOIN Livro ON Livro.ISBN = LivroInfo.ISBN
WHERE Preco > ALL (
    SELECT Preco
    FROM Livro
    WHERE ISBN IN (SELECT ISBN FROM Emprestimo WHERE Estado = 'A')
    );

SELECT Titulo, Preco
FROM Livro
WHERE Preco > ANY (SELECT Preco FROM Livro WHERE ISBN IN (SELECT ISBN FROM Emprestimo WHERE TipoUsuario = 'A'));
