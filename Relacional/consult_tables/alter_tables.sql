ALTER TABLE Leitor ADD CONSTRAINT email_unico_leitor UNIQUE (Email);
ALTER TABLE Funcionario ADD CONSTRAINT email_unico_funcionario UNIQUE (Email);

-- Exemplo de inserção de dados

-- Inserindo dados de João Omena na tabela Leitor
INSERT INTO Leitor (CPF, TipodeLeitor, Email, Senha) 
VALUES ('56789012345', 'P', 'joao.omena@gmail.com', '123456');

-- Inserindo dados de João Souza nas tabelas
INSERT INTO Pessoa (CPF, Nome, DatadeNascimento, CEP, NumeroEndereco) VALUES ('11111111111', 'João Souza', TO_DATE('01/01/1993', 'DD/MM/YYYY'), '12345678', '123');
INSERT INTO Telefone (CPF, Fone) VALUES ('11111111111', '123456789');

-- Inserindo dados na tabela, mas com um e-mail já cadastrado
INSERT INTO Leitor (CPF, TipodeLeitor, Email, Senha) VALUES ('11111111111', 'P', 'joao.omena@gmail.com', '123456');
INSERT INTO Funcionario (CodigoFuncionario, CPF, Cargo, Supervisor, Email, Senha, secao) VALUES (seq_cadastro_funcionario.NEXTVAL, '11111111111', 'Bibliotecário', '56789012345','joao.omena@gmail.com', '123456', 1);

SELECT CPF, Email FROM Leitor WHERE Email = 'joao.omena@gmail.com';
SELECT CPF, Email FROM Funcionario WHERE Email = 'joao.omena@gmail.com';

DELETE FROM Telefone WHERE CPF = '11111111111';
DELETE FROM Pessoa WHERE CPF = '11111111111';

COMMIT;