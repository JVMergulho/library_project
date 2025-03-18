CREATE TYPE EmprestimoType AS OBJECT (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    Estado CHAR(1),
    MAP MEMBER FUNCTION getLeitor RETURN VARCHAR2,
    MEMBER FUNCTION printEstado RETURN CHAR
);

CREATE OR REPLACE TYPE BODY EmprestimoType AS
    MAP MEMBER FUNCTION getLeitor RETURN VARCHAR2 IS
        l INTEGER := Leitor;
    BEGIN
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
    CONSTRAINT emprestimo_fk_leitor FOREIGN KEY (Leitor) REFERENCES Leitor(CPF),
    CONSTRAINT emprestimo_fk_funcionario FOREIGN KEY (Funcionario) REFERENCES Funcionario(CPF),
    CONSTRAINT emprestimo_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(CodigoTombamento),
    CONSTRAINT emprestimo_chk_estado CHECK (Estado IN ('E', 'D', 'A'))
);

CREATE TYPE Reserva AS OBJECT (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER,
    DataReserva DATE,
    DataLimite DATE,
    Estado CHAR(1)
);

CREATE TABLE Reserva OF Reserva (
    CONSTRAINT reserva_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataReserva),
    CONSTRAINT reserva_fk_leitor FOREIGN KEY (Leitor) REFERENCES Leitor(CPF),
    CONSTRAINT reserva_fk_funcionario FOREIGN KEY (Funcionario) REFERENCES Funcionario(CPF),
    CONSTRAINT reserva_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(CodigoTombamento),
    CONSTRAINT reserva_chk_estado CHECK (Estado IN ('R', 'F', 'C'))
);

CREATE TYPE MultaType AS OBJECT (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER,
    DataMulta DATE,
    DataEmprestimo DATE,
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
    CONSTRAINT multa_fk_leitor FOREIGN KEY (Leitor, Livro, Funcionario, DataEmprestimo) REFERENCES Emprestimo(Leitor, Livro, Funcionario, DataEmprestimo),
    CONSTRAINT multa_chk_status CHECK (Status IN ('A', 'P'))
);