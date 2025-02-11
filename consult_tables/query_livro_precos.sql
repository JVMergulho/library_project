SELECT Editora, MAX(Preco) FROM LivroInfo
JOIN Livro ON LivroInfo.ISBN = Livro.ISBN
GROUP BY Editora;

SELECT MIN(Preco) FROM Livro;

SELECT RestricaoUsuario, AVG(Preco) FROM LivroInfo
JOIN Livro ON LivroInfo.ISBN = Livro.ISBN
GROUP BY RestricaoUsuario;





