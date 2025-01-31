
-- levando em consideração que CEP pode ter hífen
-- e que o número de telefone pode ter parênteses e traço
-- e que o CPF pode ter pontos e traço
-- e que o número do endereço pode ter letras ou ser SN (sem número)

CREATE TABLE Pessoa (
    CPF VARCHAR2(14),
    Nome VARCHAR2(50),
    DatadeNascimento DATE,
    CEP VARCHAR2(9),
    NumeroEndereco VARCHAR2(10),
    CONSTRAINT pessoa_pk PRIMARY KEY ( CPF ),
    CONSTRAINT pessoa_fk_logradouro FOREIGN KEY ( CEP ) REFERENCES Logradouro(CEP)
);

CREATE TABLE Logradouro (
    CEP VARCHAR2(8),
    Rua VARCHAR2(50),
    CONSTRAINT logradouro_pk PRIMARY KEY ( CEP )
);

CREATE TABLE Telefone (
    CPF VARCHAR2(14),
    Fone VARCHAR2(20),
    CONSTRAINT telefone_pk PRIMARY KEY ( CPF, Fone ),
    CONSTRAINT telefone_fk_pessoa FOREIGN KEY ( CPF ) REFERENCES Pessoa(CPF)
);