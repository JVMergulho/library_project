-- Definição do tipo objeto
CREATE OR REPLACE TYPE nome_cpf AS OBJECT (
    CPF CHAR(11),
    Nome VARCHAR2(100)
);
/

-- Definição do tipo tabela
CREATE OR REPLACE TYPE nome_cpf_table AS TABLE OF nome_cpf;
/

-- Função para listar leitores com nome começando com um prefixo
CREATE OR REPLACE FUNCTION listar_leitores_com_nome(nomeLeitor IN VARCHAR2) 
RETURN nome_cpf_table IS
    t_nome_cpf nome_cpf_table;
BEGIN
    SELECT nome_cpf(CPF, Nome)
    BULK COLLECT INTO t_nome_cpf
    FROM Pessoa P 
    WHERE Nome LIKE nomeLeitor || '%' 
    AND EXISTS (
        SELECT 1 FROM Leitor L WHERE L.CPF = P.CPF
    );

    RETURN t_nome_cpf;
END listar_leitores_com_nome;

DECLARE
    resultado nome_cpf_table;
BEGIN
    resultado := listar_leitores_com_nome('Jo');
    FOR i IN 1..resultado.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: ' || resultado(i).Nome || ', CPF: ' || resultado(i).CPF);
    END LOOP;
END;