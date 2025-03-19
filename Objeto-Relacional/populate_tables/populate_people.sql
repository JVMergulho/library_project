INSERT INTO Pessoa VALUES (
    PessoaType(
        TelefonesType('81987654321'),  
        19900101,                     
        12345678901,                  
        'Ryei Moraes'                 
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
        TelefonesType(),  
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
