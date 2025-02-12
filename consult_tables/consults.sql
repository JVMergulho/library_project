-- quantos títulos distintos tem em cada seção?
SELECT COUNT(*) FROM LivroInfo GROUP BY Secao;

-- quantas unidades existe em cada seção (levando em conta apenas as seções com livros cadastrados)?
SELECT S.Nome, COUNT(L.CodigoTombamento) AS Quantidade
FROM Livro L
JOIN LivroInfo LI ON L.ISBN = LI.ISBN
JOIN Secao S ON LI.SecaoID = S.ID
GROUP BY S.Nome
ORDER BY Quantidade DESC;

-- Cria uma view que mostra o CPF, data da multa e status de todas as multas
CREATE VIEW Leitor_Multa AS 
SELECT L.CPF, M.DataMulta, M.Status
FROM Leitor L
JOIN Multa M ON L.CPF = M.Leitor;

-- União dos títulos de livros com restrição de usuário 'R' e 'A'   
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'R')
UNION 
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'A');
