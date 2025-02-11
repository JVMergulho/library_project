
UPDATE Livro
SET Preco = Preco * 0.9
WHERE Preco BETWEEN 20 AND 49.99;

UPDATE Livro
SET Preco = Preco * 0.8
WHERE Preco BETWEEN 50 AND 100;

