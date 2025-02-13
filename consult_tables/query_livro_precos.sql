SELECT Editora, MAX(Preco) FROM LivroInfo
JOIN Livro ON LivroInfo.ISBN = Livro.ISBN
GROUP BY Editora;

SELECT Titulo, Preco FROM LivroInfo
JOIN Livro ON Livro.ISBN = LivroInfo.ISBN
WHERE Preco = (SELECT MIN(Preco) FROM Livro);

SELECT AVG(Preco) FROM Livro;

SELECT Titulo, Preco
FROM LivroInfo
JOIN Livro ON Livro.ISBN = LivroInfo.ISBN
WHERE Preco > (SELECT AVG(Preco) FROM Livro);

UPDATE Livro
SET Preco = Preco * 0.9
WHERE Preco BETWEEN 20 AND 49.99;

UPDATE Livro
SET Preco = Preco * 0.8
WHERE Preco BETWEEN 50 AND 100;

SELECT RestricaoUsuario, AVG(Preco) FROM LivroInfo
JOIN Livro ON LivroInfo.ISBN = Livro.ISBN
GROUP BY RestricaoUsuario;





