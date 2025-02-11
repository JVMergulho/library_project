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


-- Criando o pacote
CREATE OR REPLACE PACKAGE pkg_emprestimo_livro AS
    TYPE pessoa_cpf_email IS RECORD (
        CPF Pessoa.CPF%TYPE,
        Email Pessoa.Email%TYPE,
        Nome Pessoa.Nome%TYPE
    );

    TYPE TabelaPessoa IS TABLE OF pessoa_cpf_email INDEX BY BINARY_INTEGER;
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
        pessoas TabelaPessoa := TabelaPessoa(); -- Inicializa a coleção
    BEGIN
        FOR reg IN (
            SELECT DISTINCT P.CPF, P.Nome 
            FROM Pessoa P
            JOIN Emprestimo E ON P.CPF = E.Leitor
        ) LOOP
            pessoas.EXTEND;
            pessoas(pessoas.LAST) := pessoa_cpf_email(reg.CPF, reg.Nome);
        END LOOP;
        RETURN pessoas; -- Retorna a coleção
    END listar_leitores_com_emprestimos;

    -- Função livros_preco_entre
    FUNCTION livros_preco_entre (preco_minimo IN NUMBER, preco_maximo IN NUMBER) 
    RETURN Livro_metadado IS
        livros Livro_metadado := Livro_metadado(); -- Inicializa a coleção
    BEGIN
        FOR reg IN (
            SELECT * FROM Livro
            WHERE Preco BETWEEN preco_minimo AND preco_maximo
        ) LOOP
            livros.EXTEND;
            livros(livros.LAST) := reg;
        END LOOP;
        RETURN livros; -- Retorna a coleção
    END livros_preco_entre;

    -- Função preco_maximo_livro
    FUNCTION preco_maximo_livro RETURN NUMBER IS
        preco_max NUMBER;
    BEGIN
        SELECT MAX(Preco) INTO preco_max
        FROM LivroInfo L;
        RETURN preco_max;
    END preco_maximo_livro;

END pkg_emprestimo_livro;

-- Triggers
CREATE OR REPLACE TRIGGER checa_datas_reserva 
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF :NEW.DataLimite IS NULL THEN
        :NEW.DataLimite := :NEW.DataReserva + 7;
    END IF;
END;

CREATE OR REPLACE TRIGGER log_livros
AFTER INSERT OR DELETE OR UPDATE ON Livro
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) inserido(s)');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) atualizado(s)');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Livro(s) deletado(s)');
    END IF;
END;

CREATE OR REPLACE TRIGGER checa_data_reserva
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF :NEW.DataReserva > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20000, 'Data de reserva não pode ser uma data futura');
    END IF;
END checa_data_reserva;
