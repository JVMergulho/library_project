-- Inserindo dados na tabela Logradouro
INSERT ALL
    INTO Logradouro (CEP, Rua) VALUES ('12345678', 'Rua dos Bobos')
    INTO Logradouro (CEP, Rua) VALUES ('12358232', 'Rua dos Pobres')
    INTO Logradouro (CEP, Rua) VALUES ('84561259', 'Rua dos Ricos')
SELECT * FROM dual;

-- Inserindo dados na tabela Pessoa
INSERT ALL
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('12345678901', 'Ryei Moraes', TO_DATE('01/01/1990', 'DD/MM/YYYY'), '12345678', '0')
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('98765432100', 'Leticia Pedrosa', TO_DATE('01/02/1995', 'DD/MM/YYYY'), '12358232', '152')
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('56789012345', 'João Omena', TO_DATE('01/03/2000', 'DD/MM/YYYY'), '84561259', '516')
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('98765432110', 'Sofia Lima', TO_DATE('01/04/2005', 'DD/MM/YYYY'), '12345678', '0')
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('56234565444', 'Pedro Monte', TO_DATE('01/05/2010', 'DD/MM/YYYY'), '12358232', '152')
    INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('15468718901', 'João Mergulhão', TO_DATE('01/06/2015', 'DD/MM/YYYY'), '84561259', '516')
SELECT * FROM dual;

-- Inserindo dados na tabela Telefone
INSERT ALL
    INTO Telefone (CPF, Fone) VALUES ('12345678901', '81987654321')
    INTO Telefone (CPF, Fone) VALUES ('98765432100', '81912345678')
    INTO Telefone (CPF, Fone) VALUES ('56789012345', '81954654132')
SELECT * FROM dual;

-- Inserindo dados na tabela Leitor
INSERT ALL
    INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES ('98765432110', 'P', 'sofia.lima@gmail.com', '123456')
    INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES ('56234565444', 'A', 'pedro.monte', '654321')
    INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES ('15468718901', 'I', 'joao.mergulhao', '987654')
SELECT * FROM dual;

-- Inserindo dados na tabela Secao
INSERT INTO Secao (ID, Nome) VALUES (seq_id_secao.NEXTVAL, 'Infantil');
INSERT INTO Secao (ID, Nome) VALUES (seq_id_secao.NEXTVAL, 'Literatura Clássica');

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (CodigoFuncionario, CPF, Cargo, Supervisor, Email, Senha, secao) 
VALUES (seq_cadastro_funcionario.NEXTVAL, '98765432100', 'Chefe da Seção', NULL, 'leticia.pedrosa@gmail.com', '654321', 2);

INSERT INTO Funcionario (CodigoFuncionario, CPF, Cargo, Supervisor, Email, Senha, secao) 
VALUES (seq_cadastro_funcionario.NEXTVAL, '56789012345', 'Chefe da Seção', NULL, 'joao.omena@gmail.com', '987654', 1);

INSERT INTO Funcionario (CodigoFuncionario, CPF, Cargo, Supervisor, Email, Senha, secao) 
VALUES (seq_cadastro_funcionario.NEXTVAL, '12345678901', 'Bibliotecário', '56789012345', 'ryei.moraes@gmail.com', '123456', 1);

COMMIT;