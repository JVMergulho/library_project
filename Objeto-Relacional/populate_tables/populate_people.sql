
INSERT INTO Secao VALUES (SecaoType(1, 'Infantil'));
INSERT INTO Secao VALUES (SecaoType(2, 'Literatura Clássica'));

COMMIT;



INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81987654321'),  -- Telefones
        19900101,                     -- DataNascimento (AAAAMMDD)
        12345678901,                  -- CPF
        'Ryei Moraes'                 -- Nome
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81912345678'),
        19950201,
        98765432100,
        'Leticia Pedrosa'
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81954654132'),
        20000301,
        56789012345,
        'João Omena'
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),  -- Sem telefone
        20050401,
        98765432110,
        'Sofia Lima'
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),
        20100501,
        56234565444,
        'Pedro Monte'
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),
        20150601,
        15468718901,
        'João Mergulhão'
    )
);

COMMIT;




INSERT INTO Funcionario VALUES (
    FuncionarioType(
       'leticia.pedrosa@gmail.com',
       100,                -- CodigoFuncionario
       'Chefe da Seção',  -- Cargo
       '654321'           -- Senha
    )
);

UPDATE Funcionario f
   SET f.CPF            = 98765432100,
       f.Nome           = 'Leticia Pedrosa',
       f.DataNascimento = 19950201,  -- AAAAMMDD
       f.Telefones      = TelefonesType('81912345678'),
       f.Secao = (SELECT REF(s) FROM Secao s
                   WHERE s.CodigoSecao = 2) -- Literatura Clássica
 WHERE f.CodigoFuncionario = 100;

COMMIT;


INSERT INTO Funcionario VALUES (
    FuncionarioType(
       'joao.omena@gmail.com',
       200,
       'Chefe da Seção',
       '987654'
    )
);

UPDATE Funcionario f
   SET f.CPF            = 56789012345,
       f.Nome           = 'João Omena',
       f.DataNascimento = 20000301,
       f.Telefones      = TelefonesType('81954654132'),
       f.Secao = (SELECT REF(s) FROM Secao s
                   WHERE s.CodigoSecao = 1) -- Infantil
 WHERE f.CodigoFuncionario = 200;

COMMIT;


-- 3.3) Ryei Moraes (CódigoFuncionario=300), supervisor=João Omena
INSERT INTO Funcionario VALUES (
    FuncionarioType(
       'ryei.moraes@gmail.com',
       300,
       'Bibliotecário',
       '123456'
    )
);

UPDATE Funcionario f
   SET f.CPF            = 12345678901,
       f.Nome           = 'Ryei Moraes',
       f.DataNascimento = 19900101,
       f.Telefones      = TelefonesType('81987654321'),
       f.Secao = (SELECT REF(s) FROM Secao s
                   WHERE s.CodigoSecao = 1),
       f.supervisor = (SELECT REF(fs)
                         FROM Funcionario fs
                        WHERE fs.CodigoFuncionario = 200)
 WHERE f.CodigoFuncionario = 300;

COMMIT;



INSERT INTO Leitor VALUES (
    LeitorType(
       'sofia.lima@gmail.com',  -- Email
       'P',                     -- TipoLeitor
       '123456'                 -- Senha
    )
);

UPDATE Leitor l
   SET l.CPF            = 98765432110,
       l.Nome           = 'Sofia Lima',
       l.DataNascimento = 20050401,
       l.Telefones      = TelefonesType()
 WHERE l.Email = 'sofia.lima@gmail.com';

COMMIT;


-- 4.2) Pedro Monte
INSERT INTO Leitor VALUES (
    LeitorType(
       'pedro.monte',  -- Email
       'A',            -- TipoLeitor
       '654321'        -- Senha
    )
);

UPDATE Leitor l
   SET l.CPF            = 56234565444,
       l.Nome           = 'Pedro Monte',
       l.DataNascimento = 20100501,
       l.Telefones      = TelefonesType()
 WHERE l.Email = 'pedro.monte';

COMMIT;


-- 4.3) João Mergulhão
INSERT INTO Leitor VALUES (
    LeitorType(
       'joao.mergulhao', -- Email
       'I',              -- TipoLeitor
       '987654'          -- Senha
    )
);

UPDATE Leitor l
   SET l.CPF            = 15468718901,
       l.Nome           = 'João Mergulhão',
       l.DataNascimento = 20150601,
       l.Telefones      = TelefonesType()
 WHERE l.Email = 'joao.mergulhao';

COMMIT;
