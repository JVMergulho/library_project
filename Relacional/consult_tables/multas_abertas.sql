-- Cria uma view que mostra o CPF, data da multa e status de todas as multas
CREATE VIEW Leitor_Multa_aberta AS 
SELECT L.CPF, M.DataMulta, M.Status
FROM Leitor L
RIGHT JOIN Multa M ON L.CPF = M.Leitor
WHERE M.Status = 'A';

CREATE OR REPLACE PROCEDURE quantas_multas_abertas (
    LeitorCPF IN VARCHAR2, 
    DataInicio IN DATE
) AS
    total_multas NUMBER;
    mensagem VARCHAR2(400);
BEGIN
    -- Obtém a contagem de multas
    SELECT COUNT(*) INTO total_multas
    FROM Leitor_Multa_aberta
    WHERE CPF = LeitorCPF 
      AND DataMulta >= DataInicio;

    -- Usando CASE dentro de uma expressão SQL para definir a mensagem
    SELECT 
        CASE 
            WHEN total_multas = 0 THEN 'Nenhuma multa aberta encontrada.'
            WHEN total_multas = 1 THEN 'Uma multa aberta encontrada.'
            ELSE 'O leitor de CPF ' || LeitorCPF || ' está proibido de fazer novos empréstimos. Total de multas: ' || total_multas
        END 
    INTO mensagem
    FROM DUAL;

    -- Exibir a mensagem
    DBMS_OUTPUT.PUT_LINE(mensagem);
END quantas_multas_abertas;