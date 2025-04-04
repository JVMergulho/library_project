DROP TABLE Emprestimo CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Multa CASCADE CONSTRAINTS;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE AÇÕES/ RELACIONAMENTOS ENTRE PESSOAS E LIVROS

CREATE TYPE EmprestimoType AS OBJECT (
    Leitor REF LeitorType,
    Funcionario REF FuncionarioType,
    Livro REF LivroType,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    Estado CHAR(1),
    MAP MEMBER FUNCTION getLeitor RETURN VARCHAR2,
    MEMBER PROCEDURE printEstado
);
/

CREATE OR REPLACE TYPE BODY EmprestimoType AS
    MAP MEMBER FUNCTION getLeitor RETURN VARCHAR2 IS
        l VARCHAR2(100);
    BEGIN
        SELECT DEREF(Self.Leitor).Nome INTO l FROM DUAL;
        RETURN l;
    END getLeitor;

    MEMBER PROCEDURE printEstado IS
        e CHAR := Estado;
        l VARCHAR2(100);
        message VARCHAR2(100);
    BEGIN
        l := DEREF(Self.Leitor).Nome; 

        CASE e
            WHEN 'E' THEN
                message := 'Emprestado/ em andamento';
            WHEN 'D' THEN
                message := 'Estado do empréstimo: Devolvido';
            WHEN 'A' THEN
                message := 'Estado do empréstimo: Atrasado';
            ELSE
                message := 'Estado do empréstimo: Desconhecido';
        END CASE;

        DBMS_OUTPUT.PUT_LINE('Estado do empréstimo do leitor ' || l || ': ' || message);

    END printEstado;
END;
/

CREATE TABLE Emprestimo OF EmprestimoType (
    CONSTRAINT emprestimo_chk_estado CHECK (Estado IN ('E', 'D', 'A')),
    Livro WITH ROWID REFERENCES Livro,
    Funcionario WITH ROWID REFERENCES Funcionario,
    Leitor WITH ROWID REFERENCES Leitor
);

CREATE TYPE ReservaType AS OBJECT (
    Leitor REF LeitorType,
    Funcionario REF FuncionarioType,
    Livro REF LivroType,
    DataReserva DATE,
    DataLimite DATE,
    Estado CHAR(1)
);
/

CREATE TABLE Reserva OF ReservaType (
    CONSTRAINT reserva_chk_estado CHECK (Estado IN ('R', 'F', 'C')),
    Livro WITH ROWID REFERENCES Livro,
    Funcionario WITH ROWID REFERENCES Funcionario,
    Leitor WITH ROWID REFERENCES Leitor
);

CREATE TYPE MultaType AS OBJECT (
    Emprestimo REF EmprestimoType,
    DataMulta DATE,
    Status CHAR(1),
    TaxaDiaria NUMBER(10,2),
    ValorMaximo NUMBER(10,2),
    ORDER MEMBER FUNCTION comparaMulta(X MultaType) RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY MultaType AS
    ORDER MEMBER FUNCTION comparaMulta(X MultaType) RETURN NUMBER IS
        d1 NUMBER := SYSDATE - DataMulta;
        t1 NUMBER := TaxaDiaria;
        valor1 NUMBER := d1 * t1;

        d2 NUMBER := SYSDATE - X.DataMulta;
        t2 NUMBER := X.TaxaDiaria;
        valor2 NUMBER := d2 * t2;
    BEGIN
        RETURN valor1 - valor2;
    END;
END;
/

CREATE TABLE Multa OF MultaType (
    CONSTRAINT multa_chk_status CHECK (Status IN ('A', 'P')),
    Emprestimo WITH ROWID REFERENCES Emprestimo
);