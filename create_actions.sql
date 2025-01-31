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
    CONSTRAINT emprestimo_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(ID),
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
    CONSTRAINT reserva_fk_livro FOREIGN KEY (Livro) REFERENCES Livro(ID),
    CONSTRAINT check_estado_reserva CHECK (Estado IN ('R', 'F', 'C'))
);