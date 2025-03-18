-- quantas unidades existe em cada seção (levando em conta apenas as seções com livros cadastrados)?
SELECT S.Nome, COUNT(L.CodigoTombamento) AS Quantidade
FROM Livro L
JOIN LivroInfo LI ON L.ISBN = LI.ISBN
JOIN Secao S ON LI.SecaoID = S.ID
GROUP BY S.Nome
ORDER BY Quantidade DESC;

-- União dos títulos de livros com restrição de usuário 'R' e 'A'   
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'R')
UNION 
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'A');