-- quantos títulos distintos tem em cada seção?
SELECT COUNT(*) FROM LivroInfo GROUP BY Secao;

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

-- Cria uma view que mostra o CPF, data da multa e status de todas as multas
CREATE VIEW Leitor_Multa AS 
SELECT L.CPF, M.DataMulta, M.Status
FROM Leitor L
JOIN Multa M ON L.CPF = M.Leitor;

CREATE OR REPLACE PROCEDURE quantas_multas_abertas (
    CPF IN VARCHAR2, 
    DataInicio IN DATE
) AS
    total_multas NUMBER;
    mensagem VARCHAR2(400);
BEGIN
    -- Obtém a contagem de multas
    SELECT COUNT(*) INTO total_multas
    FROM Multas
    WHERE Leitor = CPF 
      AND DataMulta >= DataInicio 
      AND Status = 'A';

    -- Usando CASE dentro de uma expressão SQL para definir a mensagem
    SELECT 
        CASE 
            WHEN total_multas = 0 THEN 'Nenhuma multa aberta encontrada.'
            WHEN total_multas = 1 THEN 'Uma multa aberta encontrada.'
            ELSE 'O leitor de CPF ' || CPF || ' está proibido de fazer novos empréstimos. Total de multas: ' || total_multas
        END 
    INTO mensagem
    FROM DUAL;

    -- Exibir a mensagem
    DBMS_OUTPUT.PUT_LINE(mensagem);
END quantas_multas;