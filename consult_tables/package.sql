-- Criando o pacote
CREATE OR REPLACE PACKAGE pkg_emprestimo_livro AS
    TYPE pessoa_cpf IS RECORD (
        CPF Pessoa.CPF%TYPE,
        Nome Pessoa.Nome%TYPE
    );

    TYPE TabelaPessoa IS TABLE OF pessoa_cpf INDEX BY BINARY_INTEGER;
    TYPE Livro_metadado IS TABLE OF Livro%ROWTYPE INDEX BY BINARY_INTEGER;

    FUNCTION listar_leitores_com_emprestimos RETURN TabelaPessoa;

    FUNCTION livros_preco_entre (preco_minimo IN NUMBER, preco_maximo IN NUMBER) 
    RETURN Livro_metadado;

    FUNCTION preco_maximo_livro RETURN NUMBER;

END pkg_emprestimo_livro;

-- Corpo do pacote
CREATE OR REPLACE PACKAGE BODY pkg_emprestimo_livro AS
    
    -- Função listar_leitores_com_emprestimos
    FUNCTION listar_leitores_com_emprestimos RETURN TabelaPessoa IS
        pessoas TabelaPessoa;
        idx BINARY_INTEGER := 0;
    BEGIN
        pessoas.DELETE; -- Garante que a coleção está vazia
        FOR reg IN (
            SELECT DISTINCT P.CPF, P.Nome 
            FROM Pessoa P
            JOIN Emprestimo E ON P.CPF = E.Leitor
        ) LOOP
            idx := idx + 1;
            pessoas(idx).CPF := reg.CPF;
            pessoas(idx).Nome := reg.Nome;
        END LOOP;
        RETURN pessoas;
    END listar_leitores_com_emprestimos;

    -- Função livros_preco_entre
    FUNCTION livros_preco_entre (preco_minimo IN NUMBER, preco_maximo IN NUMBER) 
    RETURN Livro_metadado IS
        livros Livro_metadado;
        idx BINARY_INTEGER := 0;
    BEGIN
        livros.DELETE; -- Garante que a coleção está vazia
        FOR reg IN (
            SELECT * FROM Livro
            WHERE Preco BETWEEN preco_minimo AND preco_maximo
        ) LOOP
            idx := idx + 1;
            livros(idx) := reg;
        END LOOP;
        RETURN livros;
    END livros_preco_entre;

    -- Função preco_maximo_livro
    FUNCTION preco_maximo_livro RETURN NUMBER IS
        preco_max NUMBER;
    BEGIN
        SELECT MAX(Preco) INTO preco_max
        FROM Livro;
        RETURN preco_max;
    END preco_maximo_livro;

END pkg_emprestimo_livro;

COMMIT;