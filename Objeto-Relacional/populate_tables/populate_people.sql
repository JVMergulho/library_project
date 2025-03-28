-- Inserindo as seções
INSERT INTO Secao VALUES (SecaoType(1, 'Infantil'));
INSERT INTO Secao VALUES (SecaoType(2, 'Literatura Clássica'));
COMMIT;

-- Inserindo as Pessoas com Endereço
INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81987654321'),  -- Telefones
        TO_DATE('1990-01-01', 'YYYY-MM-DD'), -- DataNascimento
        12345678901,                  -- CPF
        'Ryei Moraes',                -- Nome
        EnderecoType('Rua A', 100, 12345)  -- Endereço
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81912345678'),
        TO_DATE('1995-02-01', 'YYYY-MM-DD'), -- DataNascimento
        98765432100,
        'Leticia Pedrosa',
        EnderecoType('Rua B', 200, 54321)  -- Endereço
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81954654132'),
        TO_DATE('2000-03-01', 'YYYY-MM-DD'), -- DataNascimento
        56789012345,
        'João Omena',
        EnderecoType('Rua C', 300, 67890)  -- Endereço
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),  -- Sem telefone
        TO_DATE('2005-04-01', 'YYYY-MM-DD'), -- DataNascimento
        98765432110,
        'Sofia Lima',
        EnderecoType('Rua D', 400, 23456)  -- Endereço
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),
        TO_DATE('2010-05-01', 'YYYY-MM-DD'), -- DataNascimento
        56234565444,
        'Pedro Monte',
        EnderecoType('Rua E', 500, 34567)  -- Endereço
    )
);

INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType(),
        TO_DATE('2015-06-01', 'YYYY-MM-DD'), -- DataNascimento
        15468718901,
        'João Mergulhão',
        EnderecoType('Rua F', 600, 45678)  -- Endereço
    )
);

COMMIT;

-- Inserindo Funcionários
INSERT INTO Funcionario VALUES (
    FuncionarioType(
        TelefonesType(),
        TO_DATE('1995-02-01', 'YYYY-MM-DD'), -- DataNascimento
        98765432100,
        'Leticia Pedrosa',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'leticia.pedrosa@gmail.com',
        100,                -- CodigoFuncionario
        'Chefe da Seção',   -- Cargo
        '654321',           -- Senha
        (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 2), -- Literatura Clássica
        (SELECT REF(f) FROM Funcionario f WHERE f.CodigoFuncionario = 200)
    )
);

INSERT INTO Funcionario VALUES (
    FuncionarioType(
        TelefonesType(),
        TO_DATE('2000-03-01', 'YYYY-MM-DD'), -- DataNascimento
        56789012345,
        'João Omena',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'joao.omena@gmail.com',
        200,
        'Chefe da Seção',
        '987654',
        (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 1), -- Infantil
        (SELECT REF(f) FROM Funcionario f WHERE f.CodigoFuncionario = 200)
    )
);

-- Inserindo Ryei Moraes (CódigoFuncionario=300), supervisor=João Omena
INSERT INTO Funcionario VALUES (
    FuncionarioType(
        TelefonesType(),
        TO_DATE('1990-01-01', 'YYYY-MM-DD'), -- DataNascimento
        12345678901,
        'Ryei Moraes',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'ryei.moraes@gmail.com',
        300,
        'Bibliotecário',
        '123456',
        (SELECT REF(s) FROM Secao s WHERE s.CodigoSecao = 1),  -- Infantil
        (SELECT REF(f) FROM Funcionario f WHERE f.CodigoFuncionario = 200) -- Supervisor: João Omena
    )
);

COMMIT;

-- Inserindo Leitores
INSERT INTO Leitor VALUES (
    LeitorType(
        TelefonesType(),
        TO_DATE('2005-04-01', 'YYYY-MM-DD'), -- DataNascimento
        98765432110,
        'Sofia Lima',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'sofia.lima@gmail.com',  -- Email
        'P',                     -- TipoLeitor
        '123456'                 -- Senha
    )
);

INSERT INTO Leitor VALUES (
    LeitorType(
        TelefonesType(),
        TO_DATE('2010-05-01', 'YYYY-MM-DD'), -- DataNascimento
        56234565444,
        'Pedro Monte',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'pedro.monte',  -- Email
        'A',            -- TipoLeitor
        '654321'        -- Senha
    )
);

INSERT INTO Leitor VALUES (
    LeitorType(
        TelefonesType(),
        TO_DATE('2015-06-01', 'YYYY-MM-DD'), -- DataNascimento
        15468718901,
        'João Mergulhão',
        EnderecoType('Rua F', 600, 45678),  -- Endereço
        'joao.mergulhao', -- Email
        'I',              -- TipoLeitor
        '987654'          -- Senha
    )
);

COMMIT;
