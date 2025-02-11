-- quantos títulos distintos tem em cada seção?
SELECT COUNT(*) FROM LivroInfo GROUP BY Secao;

-- quantas unidades existe em cada seção (levando em conta apenas as seções com livros cadastrados)?
SELECT S.NomeSecao, COUNT(L.CodigoTombamento) AS Quantidade
FROM Livro L
JOIN Secao S ON L.IDSecao = S.IDSecao
GROUP BY S.NomeSecao
HAVING COUNT(L.CodigoTombamento) > 0
ORDER BY Quantidade DESC;

-- Cria uma view que mostra o CPF, nome, data da multa e status de todas as multas
CREATE VIEW Leitor_Multa AS 
SELECT L.CPF, L.Nome, M.DataMulta, M.Status
FROM Leitor L
JOIN Multa M ON L.CPF = M.CPFLeitor;

-- União dos títulos de livros com restrição de usuário 'R' e 'A'   
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'R')
UNION 
(SELECT L.Titulo FROM LivroInfo L 
WHERE L.RestricaoUsuario = 'A');

-- Criando o pacote corretamente
CREATE OR REPLACE PACKAGE pkg_types AS
    TYPE pessoa_cpf_email IS RECORD (
        CPF Pessoa.CPF%TYPE,
        Email Pessoa.Email%TYPE,
        Nome Pessoa.Nome%TYPE  -- Adicionando um nome para a coluna
    );

    TYPE Tabela_pessoa IS TABLE OF pessoa_cpf_email INDEX BY BINARY_INTEGER;
    TYPE Livro_metadado IS TABLE OF Livro%ROWTYPE INDEX BY BINARY_INTEGER;
END pkg_types;

-- Criando a função usando esse tipo TABLE
CREATE OR REPLACE FUNCTION listar_leitores_com_emprestimos 
RETURN TabelaPessoa IS
    pessoas TabelaPessoa := TabelaPessoa(); -- Inicializa a coleção
BEGIN
    FOR reg IN (
        SELECT DISTINCT P.CPF, P.Nome 
        FROM Pessoa P
        JOIN Emprestimo E ON P.CPF = E.Leitor
    ) LOOP
        -- Adiciona um novo elemento na coleção
        pessoas.EXTEND;
        pessoas(pessoas.LAST) := PessoaRow(reg.CPF, reg.Nome);
    END LOOP;

    RETURN pessoas; -- Retorna a coleção completa
END listar_leitores_com_emprestimos;

-- Quais livros estão com preço entre um intervalo?
CREATE OR REPLACE FUNCTION livros_preco_entre (preco_minimo IN NUMBER, preco_maximo IN NUMBER) 
RETURN pkg_types.Livro_metadado IS
    livros pkg_types.Livro_metadado := pkg_types.Livro_metadado(); -- Inicializa a coleção
BEGIN
    FOR reg IN (
        SELECT * FROM Livro
        WHERE Preco BETWEEN preco_minimo AND preco_maximo
    ) LOOP
        -- Adiciona um novo elemento na coleção
        livros.EXTEND;
        livros(livros.LAST) := reg;
    END LOOP;

    RETURN livros; -- Retorna a coleção completa
END livros_preco_entre;

-- Qual o livro com o maior preço?
CREATE OR REPLACE FUNCTION preco_maximo_livro 
RETURN NUMBER IS
    livro_nome Livro.Nome%Type;
BEGIN
    SELECT L.Nome INTO livro_nome
    FROM LivroInfo L
    WHERE L.Preco IN (SELECT MAX(Preco) FROM LivroInfo);
END preco_maximo_livro;