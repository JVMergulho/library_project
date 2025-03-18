-- Checa se um leitor pode emprestar um livro com base em suas restrições de usuário
CREATE OR REPLACE PROCEDURE checa_retricao (
    p_CPF IN VARCHAR2, -- Renomeei o parâmetro para evitar conflito
    p_ISBN IN VARCHAR2 -- Renomeei o parâmetro para evitar conflito
) AS 
    TYPE tabela_char IS TABLE OF CHAR(1) INDEX BY BINARY_INTEGER;

    t_tiposdeUsuario tabela_char;
    v_restricaoUsuario CHAR(1);
    v_tipoUsuario CHAR(1);
    v_count NUMBER := 0;
    v_index NUMBER := 1;
BEGIN
    -- Verifica se o livro existe e obtém a restrição
    BEGIN
        SELECT RestricaoUsuario INTO v_restricaoUsuario 
        FROM LivroInfo
        WHERE ISBN = p_ISBN;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Livro com ISBN ' || p_ISBN || ' não encontrado.');
            RETURN;
    END;

    -- Verifica se o leitor existe e obtém o tipo de leitor
    BEGIN
        SELECT TipodeLeitor INTO v_tipoUsuario 
        FROM Leitor
        WHERE CPF = p_CPF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Leitor com CPF ' || p_CPF || ' não encontrado.');
            RETURN;
    END;

    -- Obtém as restrições de empréstimo para o livro
    SELECT RestricaoUsuario
    BULK COLLECT INTO t_tiposdeUsuario 
    FROM Permissao
    WHERE RestricaoUsuario = v_restricaoUsuario;

    -- Verifica se o tipo de leitor está na lista de restrições permitidas
    v_index := 1; 
    WHILE v_index <= t_tiposdeUsuario.COUNT LOOP
        IF v_tipoUsuario = t_tiposdeUsuario(v_index) THEN
            v_count := 1;
            EXIT;
        END IF;
        v_index := v_index + 1; 
    END LOOP;

    -- Exibe o resultado
    IF v_count = 1 THEN
        DBMS_OUTPUT.PUT_LINE('O leitor de CPF ' || p_CPF || ' pode emprestar o livro de ISBN ' || p_ISBN);
    ELSE
        DBMS_OUTPUT.PUT_LINE('O leitor de CPF ' || p_CPF || ' não pode emprestar o livro de ISBN ' || p_ISBN);
    END IF;
END checa_retricao;

-- Bloco anônimo para testar a procedure
DECLARE
    v_ISBN LivroInfo.ISBN%TYPE;
    v_nomeLivro LivroInfo.Titulo%TYPE := 'O Pequeno Príncipe';
    v_CPFLivro Leitor.CPF%TYPE := '98765432110';
BEGIN
    -- Obtém o ISBN do livro
    BEGIN
        SELECT ISBN INTO v_ISBN
        FROM LivroInfo
        WHERE Titulo = v_nomeLivro;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Livro com título "' || v_nomeLivro || '" não encontrado.');
            RETURN;
    END;

    -- Testa o procedimento checa_retricao
    checa_retricao(v_CPFLivro, v_ISBN);
END;