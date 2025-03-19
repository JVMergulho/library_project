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
    MEMBER FUNCTION printEstado RETURN CHAR
);

CREATE OR REPLACE TYPE BODY EmprestimoType AS
    MAP MEMBER FUNCTION getLeitor RETURN VARCHAR2 IS
        l VARCHAR2(100);
    BEGIN
        SELECT DEREF(Leitor).Nome INTO l FROM DUAL;
        RETURN l;
    END;

    MEMBER FUNCTION printEstado RETURN CHAR IS
        e CHAR := Estado;
        l VARCHAR2 := Leitor;
        message VARCHAR2(100);
    BEGIN
        CASE e
            WHEN 'E' THEN
                message := 'Emprestado/ em andamento';
            WHEN 'D' THEN
                message := 'Estado do empréstimo: Devolvido';
            WHEN 'A' THEN
                message := 'Estado do empréstimo: Atrasado';
            ELSE
                message :=  'Estado do empréstimo: Desconhecido';
        END CASE;

        DBMS_OUTPUT.PUT_LINE("Estado do empréstimo do leitor" || l || ": " || e);
    END;
END;

CREATE TABLE Emprestimo OF EmprestimoType (
    CONSTRAINT emprestimo_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataEmprestimo),
    CONSTRAINT emprestimo_chk_estado CHECK (Estado IN ('E', 'D', 'A')),
    Livro WITH ROWID REFERENCES LivroType,
    Funcionario WITH ROWID REFERENCES FuncionarioType,
    Leitor WITH ROWID REFERENCES LeitorType
);

CREATE TYPE Reserva AS OBJECT (
    Leitor REF LeitorType,
    Funcionario REF FuncionarioType,
    Livro REF LivroType,
    DataReserva DATE,
    DataLimite DATE,
    Estado CHAR(1)
);

CREATE TABLE Reserva OF Reserva (
    CONSTRAINT reserva_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataReserva),
    CONSTRAINT reserva_chk_estado CHECK (Estado IN ('R', 'F', 'C')),
    Livro WITH ROWID REFERENCES LivroType,
    Funcionario WITH ROWID REFERENCES FuncionarioType,
    Leitor WITH ROWID REFERENCES LeitorType
);

CREATE TYPE MultaType AS OBJECT (
    Emprestimo REF EmprestimoType,
    DataMulta DATE,
    Status CHAR(1),
    TaxaDiaria NUMBER(10,2),
    ValorMaximo NUMBER(10,2),
    ORDER MEMBER FUNCTION comparaMulta(X MultaType) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY MultaType AS
    ORDER MEMBER FUNCTION comparaMulta(X MultaType) RETURN NUMBER IS
        d1 NUMBER := DataMulta - DataEmprestimo;
        t1 NUMBER := TaxaDiaria;
        valor1 NUMBER := d1 * t1;

        d2 NUMBER := X.DataMulta - X.DataEmprestimo;
        t2 NUMBER := X.TaxaDiaria;
        valor2 NUMBER := d2 * t2;
    BEGIN
        RETURN valor1 - valor2;
    END;
END;

CREATE TABLE Multa OF MultaType (
    CONSTRAINT multa_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataMulta, DataEmprestimo),
    CONSTRAINT multa_chk_status CHECK (Status IN ('A', 'P')),
    Emprestimo WITH ROWID REFERENCES EmprestimoType
);