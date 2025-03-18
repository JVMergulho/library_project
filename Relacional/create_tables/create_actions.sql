DROP TABLE Emprestimo CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Multa CASCADE CONSTRAINTS;

-- CRIAÇÃO DE TABELAS PARA CADASTRO DE AÇÕES/ RELACIONAMENTOS ENTRE PESSOAS E LIVROS

-- Estado do empréstimo:
-- E -> Emprestado/ em andamento
-- D -> Devolvido
-- A -> Atrasado

-- Empréstimo de livro mediado por um funcionário
CREATE TABLE Emprestimo (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER,
    DataEmprestimo DATE,
    DataDevolucao DATE NULL,
    Estado CHAR,
    CONSTRAINT emprestimo_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataEmprestimo),
    CONSTRAINT emprestimo_fk_leitor FOREIGN KEY (Leitor) REFERENCES Leitor(CPF),
    CONSTRAINT emprestimo_fk_funcionario FOREIGN KEY (Funcionario) REFERENCES Funcionario(CPF),
    CONSTRAINT emprestimo_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(CodigoTombamento),
    CONSTRAINT check_estado_emprestimo CHECK (Estado IN ('E', 'D', 'A'))
);

-- Estado da reserva:
-- R -> Emprestado/ em andamento
-- F -> Finalizado/ pessoa não buscou a tempo
-- C -> Concluído/ pessoa buscou a tempo

CREATE TABLE Reserva (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER,
    DataReserva DATE,
    DataLimite DATE NULL,
    Estado CHAR,
    CONSTRAINT reserva_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataReserva),
    CONSTRAINT reserva_fk_leitor FOREIGN KEY (Leitor) REFERENCES Leitor(CPF),
    CONSTRAINT reserva_fk_funcionario FOREIGN KEY (Funcionario) REFERENCES Funcionario(CPF),
    CONSTRAINT reserva_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(CodigoTombamento),
    CONSTRAINT check_estado_reserva CHECK (Estado IN ('R', 'F', 'C'))
);

-- Multa por atraso na devolução de livro
-- Status:
-- A -> Aberto
-- P -> Pago

CREATE TABLE Multa (
    Leitor VARCHAR2(14),
    Funcionario VARCHAR2(14),
    Livro INTEGER, 
    DataMulta DATE,
    DataEmprestimo DATE,
    Status CHAR(1) CHECK (Status IN ('A', 'P')),
    TaxaDiaria NUMBER(10,2),
    ValorMaximo NUMBER(10,2),
    CONSTRAINT multa_pk PRIMARY KEY (Leitor, Livro, Funcionario, DataMulta, DataEmprestimo),
    CONSTRAINT multa_fk_leitor FOREIGN KEY (Leitor, Livro, Funcionario, DataEmprestimo) 
        REFERENCES Emprestimo(Leitor, Livro, Funcionario, DataEmprestimo)
);

COMMIT;