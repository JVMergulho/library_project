-- Populando a tabela Logradouro
INSERT INTO Logradouro (CEP, Rua) VALUES ('01001-000', 'Praça da Sé');
INSERT INTO Logradouro (CEP, Rua) VALUES ('02002-000', 'Avenida Paulista');
INSERT INTO Logradouro (CEP, Rua) VALUES ('03003-000', 'Rua Vergueiro');

-- Populando a tabela Pessoa
INSERT INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES 
('123.456.789-00', 'João Silva', TO_DATE('1990-05-15', 'YYYY-MM-DD'), '01001-000', '123A');
INSERT INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES 
('987.654.321-00', 'Maria Souza', TO_DATE('1985-08-22', 'YYYY-MM-DD'), '02002-000', '456');
INSERT INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES 
('111.222.333-44', 'Carlos Mendes', TO_DATE('1978-12-10', 'YYYY-MM-DD'), '03003-000', 'SN');

-- Populando a tabela Telefone
INSERT INTO Telefone (CPF, Fone) VALUES ('123.456.789-00', '(11) 99999-1111');
INSERT INTO Telefone (CPF, Fone) VALUES ('987.654.321-00', '(21) 98888-2222');
INSERT INTO Telefone (CPF, Fone) VALUES ('111.222.333-44', '(31) 97777-3333');

-- Populando a tabela Leitor
INSERT INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES 
('123.456.789-00', 'A', 'joao@email.com', 'senha123');
INSERT INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES 
('987.654.321-00', 'P', 'maria@email.com', 'senha456');

-- Populando a tabela Secao
INSERT INTO Secao (Nome) VALUES ('Atendimento');
INSERT INTO Secao (Nome) VALUES ('Catalogação');
INSERT INTO Secao (Nome) VALUES ('Administração');

-- Populando a tabela Funcionario
INSERT INTO Funcionario (CPF, Cargo, Supervisor, Email, Senha, secao) VALUES 
('111.222.333-44', 'Bibliotecário', NULL, 'clb@biblioteca.com', 'senha789', 1);
INSERT INTO Funcionario (CPF, Cargo, Supervisor, Email, Senha, secao) VALUES 
('987.654.321-00', 'Atendente', '111.222.333-44', 'mdc2@biblioteca.com', 'senha456', 2);
